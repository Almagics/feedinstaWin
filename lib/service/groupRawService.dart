

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



  Future<int?> updateItem(GroupRawModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(), // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'group_raw_id = ?',
      whereArgs: [updatedItem.group_raw_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.group_raw_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<GroupRawModel> getItemById(int id) async {

    GroupRawModel model = GroupRawModel(group_raw_name: '');
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, columns: ['group_raw_id', 'group_raw_name'], where: 'group_raw_id = ?', whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

    model = GroupRawModel.fromMap(dbList.first);
    print('iteeeem : ${model.group_raw_id}');
    return model;
  }







}