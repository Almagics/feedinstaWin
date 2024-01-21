





import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/comReportModel.dart';
import 'package:feedinsta/model/reports/reportComModel.dart';
import 'package:feedinsta/service/comBodyService.dart';
import 'package:sqflite/sqflite.dart';

import '../model/comAnlysisBodyModel.dart';
import '../model/comBodyModel.dart';
import '../model/context/dbcontext.dart';
import '../model/itemmodel.dart';

class ReportFinalComService{
  final Dbcon database = Dbcon();
  final String tbl = "composition_tbl";

final ComBodyService _body = ComBodyService();
  // Example: Query all records




  Future<List<ReportComModel>> getCompositionResults(int comId) async {
    final Database db = await database.database;

    // Replace the query string with the actual query
    String query = '''
     SELECT
    c.com_id,
    c.com_name,
    COALESCE(SUM(cb.total_price), 0) AS com_total_price,
    COALESCE(SUM(cb.com_body_qty), 0) AS total_qty,
    cab.element_id,
    ae.element_name AS element_name,
    COALESCE(SUM(cab.ana_body_qty), 0) AS sum_ana_body_qty,
    COALESCE(SUM(rait.raw_ana_qty * cb.com_body_qty)/2, 0) AS sum_element_item,
    
    CASE
        WHEN COALESCE(SUM(rait.raw_ana_qty), 0) < COALESCE(SUM(cab.ana_body_qty), 0) THEN 'lower'
        WHEN COALESCE(SUM(rait.raw_ana_qty), 0) = COALESCE(SUM(cab.ana_body_qty), 0) THEN 'good'
        ELSE 'higher'
    END AS Status
FROM
    composition_tbl c
JOIN
    com_body_tbl cb ON c.com_id = cb.com_id
JOIN
    com_analysis_tbl cat ON c.com_ana_id = cat.com_ana_id
JOIN
    com_analysis_body cab ON cat.com_ana_id = cab.com_ana_id
JOIN
    analysis_element_tbl ae ON cab.element_id = ae.element_id
LEFT JOIN
    raw_ananlysis_tbl rait ON ae.element_id = rait.element_id
WHERE
    c.com_id =$comId
GROUP BY
    c.com_id, cab.element_id;

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
         );
       }).toList();

    }

    // Execute the query and get the result




    return compositionResults;
  }







}