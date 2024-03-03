

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


  Future<int?> updateItem(GroupComAnalysisModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(), // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'group_com_analysis_id = ?',
      whereArgs: [updatedItem.group_com_analysis_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.group_com_analysis_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<GroupComAnalysisModel> getItemById(int id) async {

    GroupComAnalysisModel model = GroupComAnalysisModel( group_com_analysis_name: '');
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, columns: ['group_com_analysis_id', 'group_com_analysis_name'], where: 'group_com_analysis_id = ?', whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

    model = GroupComAnalysisModel.fromMap(dbList.first);
    print('iteeeem : ${model.group_com_analysis_id}');
    return model;
  }




}