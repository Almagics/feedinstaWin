

import 'package:feedinsta/model/comAnlysisBodyModel.dart';
import 'package:feedinsta/service/ComService.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/comBodyModel.dart';
import '../../model/context/dbcontext.dart';
import '../../model/reports/reportComModel.dart';
import '../analysisRawService.dart';
import '../comAnlysisBodyService.dart';
import '../comBodyService.dart';

class ReportOne {

  final Dbcon database = Dbcon();
  final String tbl = "composition_tbl";

  final ComBodyService _body = ComBodyService();

  final ComService _com = ComService();


  // Example: Query all records

  final AnalysisRawService _itembody = AnalysisRawService();

  final ComAnlysisBodyService _anaBody = ComAnlysisBodyService();


  Future<List<ReportComModel>> getCompositionResults(int comId) async {
    final Database db = await database.database;

    // Replace the query string with the actual query
    String query = '''
   SELECT
    c.com_id,
    c.com_name,
    ae.element_id,
    ae.element_name,
    cab.ana_body_qty
    
    
FROM
    composition_tbl c
JOIN
    com_analysis_tbl cat ON c.com_ana_id = cat.com_ana_id
JOIN
    com_analysis_body cab ON cat.com_ana_id = cab.com_ana_id
JOIN
    analysis_element_tbl ae ON cab.element_id = ae.element_id;



    ''';

    List<ReportComModel> compositionResults = [];

    //List<Map<String, dynamic>> result = [];

    List<ComAnlysisBodyModel> result = [];


    List<ReportComModel> result2 = [];

    var bodyanaNo = await _com.getItemAnaById(comId);


    List<ComBodyModel> comntbody = await _body.getAllDataById(comId);

    print('Com Count :: ${comntbody.length}');

    if (comntbody.length > 0) {
      //result = await db.rawQuery(query);


      result = await _anaBody.getAllDataById(bodyanaNo ?? 0);


      print('Comhead Count :: ${result.length}');

      // Map the query result to a list of CompositionResult objects
      for (var item in result) {
        compositionResults.add(ReportComModel(
            comId: comId,
            comName: '',
            elementId: item.element_id ?? 0,
            elementName: item.element_name ?? '',
            sumAnaBodyQty: item.ana_body_qty ?? 0

        ));
      }
    }

    // Execute the query and get the result


    List<ReportComModel> reportList = [
      // Add your ReportComModel objects here
    ];

    Map<String, ReportComModel> groupedByElement = {};


    List<ComBodyModel> bodylist = await _body.getAllDataById(comId ?? 0);

    var totalprice = await _body.calculateTotalPrice(bodylist);
    var totalqty = await _body.calculateTotalQty(bodylist);

    print('total qty::$totalqty');

    print('total Price::$totalprice');


    for (var report in compositionResults) {
      double itemAnaQty = 0;


      // List<ComBodyModel> combody = await _body.getAllDataById(report.comId);
      for (var item in bodylist) {
        double? elementvalue = await _itembody.getItemqtyById(
            item.ram_item_id ?? 0, report.elementId ?? 0);

        print(
            'item name : ${item.item_name} value:: $elementvalue comQty::${item
                .com_body_qty}');


        itemAnaQty =
        (((elementvalue ?? 0) * (item.com_body_qty ?? 0)) + itemAnaQty);
        print('valueeee:$itemAnaQty');
      }

      print('comIdddd:${report.comId}');


      itemAnaQty = itemAnaQty / 1000;

      String status;
      double bodyqty = report.sumAnaBodyQty;
      // double itemqty = groupedByElement[report.elementName]!.sumElementItem + (report.sumElementItem);
      if (bodyqty > (itemAnaQty ?? 0)) {
        status = 'Lower';
      } else if (bodyqty < (itemAnaQty ?? 0)) {
        status = 'Higher';
      } else {
        status = 'Good';
      }


      var model = ReportComModel(
        comId: report.comId,
        comName: report.comName,
        comTotalPrice: totalprice,
        totalQty: totalqty,
        elementId: report.elementId,
        elementName: report.elementName,
        sumAnaBodyQty: report.sumAnaBodyQty,
        sumElementItem: (itemAnaQty ?? 0),
        status: status,
        // item_id: report.item_id,
        // com_ana_id: report.com_ana_id
      );


      result2.add(model);


      //  double? anaBody = await _anaBody.getItemqtyById(report.com_ana_id ??0, report.elementId ?? 0);

      // If the elementName already exists in the map, update the numeric values.
      groupedByElement[report.elementName ?? ''] = ReportComModel(
        comId: report.comId,
        comName: report.comName,
        comTotalPrice: totalprice,
        totalQty: totalqty,
        elementId: report.elementId,
        elementName: report.elementName,
        sumAnaBodyQty: report.sumAnaBodyQty,
        sumElementItem: (itemAnaQty ?? 0),
        status: status,
        // item_id: report.item_id,
        // com_ana_id: report.com_ana_id
      );
    }

    // Convert the map values back to a list.
    //  result2 = groupedByElement.values.toList();


    return result2;
  }


}
