

import 'package:feedinsta/model/groupComModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';


class GroupComService{
  final Dbcon database = Dbcon();
  final String tbl = "group_com";

//insert
  Future<int> insertData(GroupComModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<GroupComModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<GroupComModel> list = dbList.map((map) => GroupComModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'group_com_id = ?',
      whereArgs: [id],
    );
  }





  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['group_com_name'], where: 'group_com_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['group_com_name'] as String?;
    } else {
      return null;
    }
  }







  Future<List<Map<String, dynamic>>> getDropdownData() async {
    final db = await database.initDatabase();
    return await db.query(tbl, columns: ['group_com_id', 'group_com_name']);
  }




}