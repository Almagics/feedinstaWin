
import 'package:feedinsta/model/itemmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'fillDatabase.dart';

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



//create group raw tbl
        await db.execute('''
      CREATE TABLE "group_raw" (
	"group_raw_id"	INTEGER NOT NULL UNIQUE,
	"group_raw_name"	TEXT,
	PRIMARY KEY("group_raw_id" AUTOINCREMENT)
);
        ''');


//create group com analysis tbl
        await db.execute('''
      CREATE TABLE "group_com_analysis" (
	"group_com_analysis_id"	INTEGER NOT NULL UNIQUE,
	"group_com_analysis_name"	TEXT,
	PRIMARY KEY("group_com_analysis_id" AUTOINCREMENT)
);
        ''');







        //create group com  tbl
        await db.execute('''
      CREATE TABLE "group_com" (
	"group_com_id"	INTEGER NOT NULL UNIQUE,
	"group_com_name"	TEXT,
	PRIMARY KEY("group_com_id" AUTOINCREMENT)
);
        ''');






        // Create raw_item_tbl
        await db.execute('''
          CREATE TABLE "raw_item_tbl" (
	"item_id"	INTEGER NOT NULL UNIQUE,
	"item_name"	TEXT,
	"remarks"	TEXT,
	"price"	REAL,
	"ratio"	TEXT,
	"group_raw_id"	INTEGER,
	PRIMARY KEY("item_id" AUTOINCREMENT),
	FOREIGN KEY("group_raw_id") REFERENCES "group_raw"("group_raw_id")
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


        // Create com_analysis_tbl
        await db.execute('''
        
        
        
        CREATE TABLE "raw_ananlysis_tbl" (
	"raw_ana_id"	INTEGER NOT NULL UNIQUE,
	"raw_id"	INTEGER,
	"element_id"	INTEGER,
	"element_name" TEXT,
	"raw_ana_qty"	REAL,
	PRIMARY KEY("raw_ana_id" AUTOINCREMENT),
	FOREIGN KEY (raw_id) REFERENCES raw_item_tbl(item_id),
  FOREIGN KEY (element_id) REFERENCES analysis_element_tbl(element_id)
);
     
        ''');



        // Create com_analysis_tbl
        await db.execute('''
        
        
       CREATE TABLE "com_analysis_tbl" (
	"com_ana_id"	INTEGER NOT NULL UNIQUE,
	"com_ana_name"	TEXT,
	"com_ana_remarks"	TEXT,
	"group_com_analysis_id"	INTEGER,
	PRIMARY KEY("com_ana_id" AUTOINCREMENT),
	FOREIGN KEY("group_com_analysis_id") REFERENCES "group_com_analysis"("group_com_analysis_id")
);
     
        ''');



        // Create com_analysis_body
        await db.execute('''
        
       CREATE TABLE "com_analysis_body" (
	"com_ana_body_id"	INTEGER NOT NULL UNIQUE,
	"com_ana_id"	INTEGER,
	"element_id"	INTEGER,
	"ana_body_qty"	REAL,
	"element_name"	TEXT,
	PRIMARY KEY("com_ana_body_id" AUTOINCREMENT),
	FOREIGN KEY (element_id) REFERENCES analysis_element_tbl(element_id),
  FOREIGN KEY (com_ana_id) REFERENCES com_analysis_tbl(com_ana_id)
);
     
        ''');





        // Create composition_tbl
        await db.execute('''
      
      
     CREATE TABLE "composition_tbl" (
	"com_id"	INTEGER UNIQUE,
	"com_name"	TEXT,
	"com_remarks"	TEXT,
	"com_ana_id"	INTEGER,
	"total_amount"	REAL,
	"com_qty" REAL,
	"group_com_id"	INTEGER,
	FOREIGN KEY("group_com_id") REFERENCES "group_com"("group_com_id"),
	PRIMARY KEY("com_id" AUTOINCREMENT),
	FOREIGN KEY("com_ana_id") REFERENCES "com_analysis_tbl"("com_ana_id")
);
     
        ''');



        // Create com_body_tbl
        await db.execute('''
      
     CREATE TABLE "com_body_tbl" (
	"com_body_id"	INTEGER NOT NULL UNIQUE,
	"ram_item_id"	INTEGER,
	"com_body_qty"	REAL,
	"total_price"	REAL,
	"com_id"	INTEGER,
	"item_name"	TEXT,
	PRIMARY KEY("com_body_id" AUTOINCREMENT),
	FOREIGN KEY (com_id) REFERENCES composition_tbl(com_id),
	FOREIGN KEY (ram_item_id) REFERENCES com_analysis_tbl(item_id)
);
     
        ''');






      },
    );
  }

  // Example: Insert a record




}

