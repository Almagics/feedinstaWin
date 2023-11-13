





import 'package:feedinsta/model/comAnlysisModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';


class ComAnlysisService{
  final Dbcon database = Dbcon();
  final String tbl = "com_analysis_tbl";

//insert
  Future<int> insertData(ComAnlysisModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<ComAnlysisModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<ComAnlysisModel> list = dbList.map((map) => ComAnlysisModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'com_ana_id = ?',
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






}