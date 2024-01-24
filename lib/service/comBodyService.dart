





import 'package:feedinsta/model/comModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/comBodyModel.dart';
import '../model/context/dbcontext.dart';
import '../model/itemmodel.dart';

class ComBodyService{
  final Dbcon database = Dbcon();
  final String tbl = "com_body_tbl";

//insert
  Future<int> insertData(ComBodyModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<ComBodyModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<ComBodyModel> list = dbList.map((map) => ComBodyModel.fromMap(map)).toList();
    return  list;
  }


  Future<List<ComBodyModel>> getAllDataById(int itemid) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, where: 'com_id = ?', whereArgs: [itemid]);
    List<ComBodyModel> list = dbList.map((map) => ComBodyModel.fromMap(map)).toList();
    return  list;
  }

//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'com_body_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateQty(int id, double newQty, double totalPrice) async {
    final db = await database.initDatabase();

    await db.update(
      tbl,
      {'total_price': totalPrice}, // Set the new value for the 'qty' column
      where: 'com_body_id = ?',
      whereArgs: [id],
    );

    return await db.update(
      tbl,
      {'com_body_qty': newQty}, // Set the new value for the 'qty' column
      where: 'com_body_id = ?',
      whereArgs: [id],
    );
  }



  Future<double?> getItemNameById(int id) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['total_price'], where: 'com_body_id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first['total_price'] as double?;
    } else {
      return null;
    }
  }





  Future <List<int?>> extractItemIds(int com_id) async {

    var list = await getAllDataById(com_id);

    return  list.map((item) => item.ram_item_id).toList();
  }



  double calculateTotalPrice(List<ComBodyModel> comBodyList) {
    double total = 0.0;
    for (var comBody in comBodyList) {

        total += double.parse(comBody.total_price.toString()) ;

    }
    return total;
  }

  double calculateTotalQty(List<ComBodyModel> comBodyList) {
    double total = 0.0;
    for (var comBody in comBodyList) {

      total += double.parse(comBody.com_body_qty.toString()) ;

    }
    return total;
  }

}