





import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/itemmodel.dart';

class ItemService{
  final Dbcon database = Dbcon();
final String tbl = "raw_item_tbl";

//insert
  Future<int> insertData(ItemModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<ItemModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<ItemModel> list = dbList.map((map) => ItemModel.fromMap(map)).toList();
    return  list;
  }


//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'item_id = ?',
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