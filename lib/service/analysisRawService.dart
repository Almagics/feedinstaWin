





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


















}