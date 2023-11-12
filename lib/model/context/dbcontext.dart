
import 'package:feedinsta/model/itemmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbcon{



  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'feeddb.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create raw_item_tbl
        await db.execute('''
          CREATE TABLE "raw_item_tbl" (
	"item_id"	INTEGER NOT NULL UNIQUE,
	"item_name"	TEXT,
	"remarks"	TEXT,
	"price"	REAL,
	PRIMARY KEY("item_id" AUTOINCREMENT)
);
        ''');


        // Create analysis_element_tbl
        await db.execute('''
         CREATE TABLE "analysis_element_tbl" (
	"element_id"	INTEGER NOT NULL UNIQUE,
	"element_name"	TEXT,
	"element_remarks"	TEXT,
	PRIMARY KEY("element_id" AUTOINCREMENT)
);
        ''');


        // Create raw_ananlysis_tbl
        await db.execute('''
        
        
        
        CREATE TABLE "raw_ananlysis_tbl" (
	"raw_ana_id"	INTEGER NOT NULL UNIQUE,
	"raw_id"	INTEGER,
	"elememt_id"	INTEGER,
	"element_name" TEXT,
	"raw_ana_qty"	REAL,
	PRIMARY KEY("raw_ana_id" AUTOINCREMENT),
	FOREIGN KEY (raw_id) REFERENCES raw_item_tbl(item_id),
  FOREIGN KEY (elememt_id) REFERENCES analysis_element_tbl(element_id)
);
     
        ''');
      },
    );
  }

  // Example: Insert a record




}

