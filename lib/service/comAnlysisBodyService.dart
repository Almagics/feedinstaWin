





import 'package:feedinsta/model/comAnlysisModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/comAnlysisBodyModel.dart';
import '../model/context/dbcontext.dart';


class ComAnlysisBodyService{
  final Dbcon database = Dbcon();
  final String tbl = "com_analysis_body";

//insert
  Future<int> insertData(ComAnlysisBodyModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<ComAnlysisBodyModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<ComAnlysisBodyModel> list = dbList.map((map) => ComAnlysisBodyModel.fromMap(map)).toList();
    return  list;
  }


  Future<List<ComAnlysisBodyModel>> getAllDataById(int itemid) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, where: 'com_ana_id = ?', whereArgs: [itemid]);
    List<ComAnlysisBodyModel> list = dbList.map((map) => ComAnlysisBodyModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'com_ana_body_id = ?',
      whereArgs: [id],
    );







  }



  Future<List<Map<String, dynamic>>> getDropdownData() async {
    final db = await database.initDatabase();
    return await db.query(tbl, columns: ['element_id', 'element_name']);
  }







  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['element_name'], where: 'element_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['element_name'] as String?;
    } else {
      return null;
    }
  }




  Future<int> updateQty(int id, double newQty ) async {
    final db = await database.initDatabase();



    return await db.update(
      tbl,
      {'ana_body_qty': newQty}, // Set the new value for the 'qty' column
      where: 'com_ana_body_id = ?',
      whereArgs: [id],
    );
  }

  Future<double?> getItemqtyById(int comana_id,int elemetnid) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['ana_body_qty'], where: 'com_ana_id = ? AND element_id = ?', whereArgs: [comana_id,elemetnid]);

    if (result.isNotEmpty) {
      return result.first['ana_body_qty'] as double?;
    } else {
      return null;
    }
  }


}