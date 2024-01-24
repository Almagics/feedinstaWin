





import 'package:feedinsta/model/analysisRawModel.dart';
import 'package:sqflite/sqflite.dart';

import '../model/context/dbcontext.dart';
import '../model/elementModel.dart';
import '../model/itemmodel.dart';

class AnalysisRawService{
  final Dbcon database = Dbcon();
  final String tbl = "raw_ananlysis_tbl";

//insert
  Future<int> insertData(AnalysisRawModel data) async {
    final db = await database.initDatabase();
    return await db.insert(tbl, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Example: Query all records
  Future<List<AnalysisRawModel>> getAllData() async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl);
    List<AnalysisRawModel> list = dbList.map((map) => AnalysisRawModel.fromMap(map)).toList();
    return  list;
  }


  Future<List<AnalysisRawModel>> getAllDataById(int raw_id) async {
    final db = await database.initDatabase();

    List<Map<String, dynamic>> dbList = await db.query(tbl, where: 'raw_id = ?', whereArgs: [raw_id]);
    List<AnalysisRawModel> list = dbList.map((map) => AnalysisRawModel.fromMap(map)).toList();
    return  list;
  }



//delete
  Future<int> deleteItem(int id) async {
    final db = await database.initDatabase();
    return await db.delete(
      tbl,
      where: 'raw_ana_id = ?',
      whereArgs: [id],
    );
  }









  Future<double> getSumOfQuantities(List<int> itemIds,int elementid) async {
    final db = await database.initDatabase();
    List<Map<String, dynamic>> result = await db.query(
      tbl,
      where: 'raw_id IN (${itemIds.map((id) => '?').join(',')}) AND element_id = ?',
      whereArgs: [...itemIds, elementid],
    );

    double sum = 0;
    for (Map<String, dynamic> row in result) {
      sum += row['raw_ana_qty'] as double;
    }
print(' is : ${sum}');
    return sum;
  }




  Future<double?> getItemqtyById(int itemid,int elemetnid) async {
    final db = await database.initDatabase();
    var result = await db.query(tbl, columns: ['raw_ana_qty'], where: 'raw_id = ? AND element_id = ?', whereArgs: [itemid,elemetnid]);

    if (result.isNotEmpty) {
      return result.first['raw_ana_qty'] as double?;
    } else {
      return null;
    }
  }

  Future<int> updateQty(int id, double newQty ) async {
    final db = await database.initDatabase();



    return await db.update(
      tbl,
      {'raw_ana_qty': newQty}, // Set the new value for the 'qty' column
      where: 'raw_ana_id = ?',
      whereArgs: [id],
    );
  }


}