

import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/groupRawModel.dart';
import '../model/itemmodel.dart';

class GroupRawService{
  final Dbcon database = Dbcon();
  final String tbl = "group_raw";

//insert
  Future<int> insertData(GroupRawModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<GroupRawModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<GroupRawModel> list = dbList.map((map) => GroupRawModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'group_raw_id = ?',
      whereArgs: [id],
    );
  }





  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['group_raw_name'], where: 'group_raw_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['group_raw_name'] as String?;
    } else {
      return null;
    }
  }







  Future<List<Map<String, dynamic>>> getDropdownData() async {
    final db = await database.initDatabase();
    return await db.query(tbl, columns: ['group_raw_id', 'group_raw_name']);
  }




}