





import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/elementModel.dart';
import '../model/itemmodel.dart';

class ElementService {
  final Dbcon database = Dbcon();
  final String tbl = "analysis_element_tbl";

//insert
  Future<int> insertData(ElementModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<ElementModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<ElementModel> list = dbList.map((map) => ElementModel.fromMap(map))
        .toList();
    return list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'element_id = ?',
      whereArgs: [id],
    );
  }


  Future<List<Map<String, dynamic>>> getDropdownData() async {
    final db = await database.initDatabase();
    return await db.query(tbl, columns: ['element_id', 'element_name']);
  }


  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['element_name'],
        where: 'element_id = ?',
        whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['element_name'] as String?;
    } else {
      return null;
    }
  }


  Future<int?> updateItem(ElementModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(),
      // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'element_id = ?',
      whereArgs: [updatedItem.element_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.element_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<ElementModel> getItemById(int id) async {
    ElementModel model = ElementModel(element_id: 0, element_name: '');
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(
        tbl, columns: ['element_id', 'element_name', 'element_remarks'],
        where: 'element_id = ?',
        whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

    model = ElementModel.fromMap(dbList.first);
    print('iteeeem : ${model.element_id}');
    return model;
  }


}
