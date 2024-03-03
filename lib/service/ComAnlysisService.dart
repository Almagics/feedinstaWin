





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
    return await db.query(tbl, columns: ['com_ana_id', 'com_ana_name']);
  }







  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['com_ana_name'], where: 'com_ana_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['element_name'] as String?;
    } else {
      return null;
    }
  }




  Future<List<ComAnlysisModel>> getAllDataByGroup(int id) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl,columns: ['com_ana_id', 'com_ana_name'],where: 'group_com_analysis_id = ?', whereArgs: [id]);
    List<ComAnlysisModel> list = dbList.map((map) => ComAnlysisModel.fromMap(map)).toList();
    return  list;
  }


  Future<int?> updateItem(ComAnlysisModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(), // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'com_ana_id = ?',
      whereArgs: [updatedItem.com_ana_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.com_ana_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<ComAnlysisModel> getItemById(int id) async {

    ComAnlysisModel model = ComAnlysisModel(  com_ana_name: '', group_com_analysis_id: 0);
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, columns: ['com_ana_id', 'com_ana_name','com_ana_remarks','group_com_analysis_id'], where: 'com_ana_id = ?', whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

    model = ComAnlysisModel.fromMap(dbList.first);
    print('iteeeem : ${model.com_ana_id}');
    return model;
  }




}