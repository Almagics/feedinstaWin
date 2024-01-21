

import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/groupComanalysisModel.dart';
import '../model/groupRawModel.dart';
import '../model/itemmodel.dart';

class GroupComAnalysisService{
  final Dbcon database = Dbcon();
  final String tbl = "group_com_analysis";

//insert
  Future<int> insertData(GroupComAnalysisModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<GroupComAnalysisModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<GroupComAnalysisModel> list = dbList.map((map) => GroupComAnalysisModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'group_com_analysis_id = ?',
      whereArgs: [id],
    );
  }





  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['group_com_analysis_name'], where: 'group_com_analysis_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['group_com_analysis_name'] as String?;
    } else {
      return null;
    }
  }







  Future<List<Map<String, dynamic>>> getDropdownData() async {
    final db = await database.initDatabase();
    return await db.query(tbl, columns: ['group_com_analysis_id', 'group_com_analysis_name']);
  }




}