





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





  Future<String?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['item_name'], where: 'item_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['item_name'] as String?;
    } else {
      return null;
    }
  }












}