





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



  Future<double?> getItemPriceById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['price'], where: 'item_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['price'] as double?;
    } else {
      return null;
    }
  }




  Future<List<Map<String, dynamic>>> getDropdownData() async {
    final db = await database.initDatabase();
    return await db.query(tbl, columns: ['item_id', 'item_name']);
  }



  Future<List<ItemModel>> getAllDataByGroup(int id) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl,columns: ['item_id', 'item_name','price','ratio','group_raw_id','remarks'],where: 'group_raw_id = ?', whereArgs: [id]);
    List<ItemModel> list = dbList.map((map) => ItemModel.fromMap(map)).toList();
    return  list;
  }


  Future<int?> updateItem(ItemModel updatedItem) async {
    final db = await database.initDatabase();

    int rowsAffected = await db.update(
      tbl,
      updatedItem.toMap(), // Assuming toMap() is a method in ItemModel to convert it to a Map.
      where: 'item_id = ?',
      whereArgs: [updatedItem.item_id],
    );


    if (rowsAffected > 0) {
      // Update successful, return the updated item ID
      return updatedItem.item_id;
    } else {
      // Update failed, return a default or error value, e.g., -1
      return -1;
    }
  }


  Future<ItemModel> getItemById(int id) async {

    ItemModel model = ItemModel(item_name: '', remarks: '', price: 0, ratio: '', group_raw_id: 0);
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, columns: ['item_id', 'item_name', 'price', 'ratio', 'group_raw_id', 'remarks'], where: 'item_id = ?', whereArgs: [id]);

    if (dbList.isEmpty) {
      // Handle the case where the item with the specified ID is not found
      return model;
    }

     model = ItemModel.fromMap(dbList.first);
    print('iteeeem : ${model.group_raw_id}');
    return model;
  }



}