





import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/comReportModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/comAnlysisBodyModel.dart';
import '../model/comBodyModel.dart';
import '../model/context/dbcontext.dart';
import '../model/itemmodel.dart';

class ComReportService{
  final Dbcon database = Dbcon();
  final String tbl = "composition_tbl";


  // Example: Query all records



  Future<List<ComAnlysisBodyModel>> getAllAnaComBodyById(int itemid) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query('com_analysis_body', where: 'com_ana_id = ?', whereArgs: [itemid]);
    List<ComAnlysisBodyModel> list = dbList.map((map) => ComAnlysisBodyModel.fromMap(map)).toList();
    return  list;
  }



  Future<List<ComBodyModel>> getAllDataById(int itemid) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query('com_body_tbl', where: 'com_id = ?', whereArgs: [itemid]);
    List<ComBodyModel> list = dbList.map((map) => ComBodyModel.fromMap(map)).toList();
    return  list;
  }


  Future<double?> getItemqtyById(int itemid,int elemetnid) async {
    final db = await database.initDatabase();
    var result = await db.query('raw_ananlysis_tbl', columns: ['raw_ana_qty'], where: 'raw_id = ? AND elememt_id = ?', whereArgs: [itemid,elemetnid]);

    if (result.isNotEmpty) {
      return result.first['raw_ana_qty'] as double?;
    } else {
      return null;
    }
  }


  Future<double> getSumOfQuantities(List<int> itemIds,int elementid) async {
    final db = await database.initDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'raw_ananlysis_tbl',
      where: 'raw_id IN (${itemIds.map((id) => '?').join(',')}) AND element_id = ?',
      whereArgs: [...itemIds, elementid],
    );

    double sum = 0;
    for (Map<String, dynamic> row in result) {
      sum += row['raw_ana_qty'] as double;
    }
    print(' is : ${sum}');
    return sum;
  }




  Future <List<int?>> extractItemIds(int com_id) async {

    var list = await getAllDataById(com_id);

    return  list.map((item) => item.ram_item_id).toList();
  }


  Future<List<ComReportModel>> Comreport(int comid,int comanaid) async {


    List<ComReportModel> reportmodel =  [];


//items in anlysis body of com
  var listofAnaCom =  await  getAllAnaComBodyById(comanaid);

  //item in com body
    var listofItemCom =  await  getAllDataById(comid);


    //list of ids of items in com body
    var listOfAnlysisItem =   extractItemIds(comid);

    listofAnaCom.map((e) =>  {

      reportmodel.add(ComReportModel(
          element_id: e.element_id,
          element_name: e.element_name,
          com_ana_id: comanaid,
          com_id: comid,
          cqty: e.ana_body_qty,
          rqty:  0,
          stat: ''))


    });
    //item in com body



    return  reportmodel;
  }






}