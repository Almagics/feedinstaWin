

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


  Future<int?> updateItem(GroupComModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(), // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'group_com_id = ?',
      whereArgs: [updatedItem.group_com_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.group_com_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<GroupComModel> getItemById(int id) async {

    GroupComModel model = GroupComModel(group_com_name: '');
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, columns: ['group_com_id', 'group_com_name'], where: 'group_com_id = ?', whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

    model = GroupComModel.fromMap(dbList.first);
    print('iteeeem : ${model.group_com_name}');
    return model;
  }




}