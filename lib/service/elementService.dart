





import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/elementModel.dart';
import '../model/itemmodel.dart';

class ElementService{
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
    List<ElementModel> list = dbList.map((map) => ElementModel.fromMap(map)).toList();
    return  list;
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
    var result = await db.query(tbl, columns: ['element_name'], where: 'element_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['element_name'] as String?;
    } else {
      return null;
    }
  }






}