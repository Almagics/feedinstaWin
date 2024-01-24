

/*



import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/comReportModel.dart';
import 'package:feedinsta/model/reports/reportComModel.dart';
import 'package:feedinsta/service/comBodyService.dart';
import 'package:sqflite/sqflite.dart';

import '../model/comAnlysisBodyModel.dart';
import '../model/comBodyModel.dart';
import '../model/context/dbcontext.dart';
import '../model/itemmodel.dart';
import 'analysisRawService.dart';
import 'comAnlysisBodyService.dart';

class ReportFinalComService{
  final Dbcon database = Dbcon();
  final String tbl = "composition_tbl";

final ComBodyService _body = ComBodyService();
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
    
    cb.ram_item_id AS item_id,
    SUM(cb.total_price) AS com_total_price,
    SUM(cb.com_body_qty) AS total_qty,
    MAX(cab.element_id) AS element_id,
    MAX(ae.element_name) AS element_name,
    SUM(cab.ana_body_qty) AS sum_ana_body_qty,
    SUM(rat.raw_ana_qty * cb.com_body_qty) AS sum_element_item,
    CASE
        WHEN SUM(rat.raw_ana_qty * cb.com_body_qty) < SUM(cab.ana_body_qty) THEN 'lower'
        WHEN SUM(rat.raw_ana_qty * cb.com_body_qty) = SUM(cab.ana_body_qty) THEN 'good'
        ELSE 'higher'
    END AS Status
FROM composition_tbl c
JOIN com_body_tbl cb ON cb.com_id = c.com_id
JOIN com_analysis_tbl ca ON ca.com_ana_id = c.com_ana_id
JOIN com_analysis_body cab ON cab.com_ana_id = ca.com_ana_id
JOIN analysis_element_tbl ae ON ae.element_id = cab.element_id
JOIN raw_ananlysis_tbl rat ON rat.element_id = ae.element_id AND rat.raw_id = cb.ram_item_id
WHERE c.com_id = $comId
GROUP BY c.com_id, cb.ram_item_id, cab.element_id

    ''';

    List<ReportComModel> compositionResults = [];

    List<Map<String, dynamic>> result = [];



    List<ComBodyModel> comntbody = await _body.getAllDataById(comId);

    print('Com Count :: ${comntbody.length}');

    if(comntbody.length > 0){

       result = await db.rawQuery(query);

       // Map the query result to a list of CompositionResult objects
       compositionResults = result.map((map) {
         return ReportComModel(
           comId: map['com_id'],
           comName: map['com_name'],
           comTotalPrice: map['com_total_price'],
           totalQty: map['total_qty'],
           elementId: map['element_id'],
           elementName: map['element_name'],
           sumAnaBodyQty: map['sum_ana_body_qty'],
           sumElementItem: map['sum_element_item'],
           status: map['Status'],
           item_id: map['item_id'],
           com_ana_id: map['item_id'],

         );
       }).toList();

    }

    // Execute the query and get the result


    List<ReportComModel> reportList = [
      // Add your ReportComModel objects here
    ];

    Map<String, ReportComModel> groupedByElement = {};



    List<ComBodyModel> bodylist = await _body.getAllDataById(compositionResults[0].comId);

    var totalprice = _body.calculateTotalPrice(bodylist);
    var totalqty = _body.calculateTotalQty(bodylist);

    for (var report in compositionResults) {



      if (groupedByElement.containsKey(report.elementName)) {

        String status;
        double bodyqty = groupedByElement[report.elementName]!.sumAnaBodyQty + report.sumAnaBodyQty;
        double itemqty = groupedByElement[report.elementName]!.sumElementItem + report.sumElementItem;
        if (bodyqty > itemqty) {
          status = 'Lower';
        } else if (bodyqty < itemqty) {
          status = 'Higher';
        } else {
          status = 'Good';
        }

        double? itemAnaQty = await _itembody.getItemqtyById(report.item_id, report.elementId);
        double? anaBody = await _anaBody.getItemqtyById(report.com_ana_id, report.elementId);

        // If the elementName already exists in the map, update the numeric values.
        groupedByElement[report.elementName] = ReportComModel(
          comId: report.comId,
          comName: report.comName,
          comTotalPrice: totalprice,
          totalQty: totalqty,
          elementId: report.elementId,
          elementName: report.elementName,
          sumAnaBodyQty: groupedByElement[report.elementName]!.sumAnaBodyQty + report.sumAnaBodyQty,
          sumElementItem:(groupedByElement[report.elementName]!.sumAnaBodyQty + report.sumElementItem) /1000,
          status: status,
          item_id: report.item_id,
          com_ana_id: report.com_ana_id
        );
      } else {
        // If the elementName doesn't exist in the map, add a new entry.
        groupedByElement[report.elementName] = report;
      }
    }

    // Convert the map values back to a list.
    List<ReportComModel> result2 = groupedByElement.values.toList();









    return result2;
  }







}
*/
