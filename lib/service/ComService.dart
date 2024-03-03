

import 'package:feedinsta/model/comModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/itemmodel.dart';

class ComService{
  final Dbcon database = Dbcon();
  final String tbl = "composition_tbl";

//insert
  Future<int> insertData(ComModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<ComModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<ComModel> list = dbList.map((map) => ComModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'com_id = ?',
      whereArgs: [id],
    );
  }





  Future<int?> getItemAnaById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['com_ana_id'], where: 'com_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['com_ana_id'] as int?;
    } else {
      return null;
    }
  }





  Future<List<ComModel>> getAllDataByGroup(int id) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl,columns: ['com_id', 'com_name', 'total_amount', 'com_qty'],where: 'group_com_id = ?', whereArgs: [id]);
    List<ComModel> list = dbList.map((map) => ComModel.fromMap(map)).toList();
    return  list;
  }



  Future<int?> updateItem(ComModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(), // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'com_id = ?',
      whereArgs: [updatedItem.com_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.com_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<ComModel> getItemById(int id) async {

    ComModel model = ComModel(com_id: 0,  com_name: '', com_ana_id: 0, com_qty: 0, total_amount: 0, group_com_id: 0);
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, columns: ['com_id', 'com_name','com_qty','total_amount','com_remarks','com_ana_id','group_com_id'], where: 'com_id = ?', whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

    model = ComModel.fromMap(dbList.first);
    print('iteeeem : ${model.com_id}');
    return model;


  }




}