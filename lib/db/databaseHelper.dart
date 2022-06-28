import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseHelper {

  SqfliteDatabaseHelper.internal();
  static final SqfliteDatabaseHelper instance = new SqfliteDatabaseHelper.internal();
  factory SqfliteDatabaseHelper() => instance;

  static final receivein_warehouses = 'receivein_warehouses';
  static final _version = 1;

  static Database _db;

  Future<Database> get db async {
    if (_db !=null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path,'syncdatabase.db');
    print(dbPath);
    var openDb = await openDatabase(dbPath,version: _version,
    onCreate: (Database db,int version)async{
      await db.execute("""
        CREATE TABLE $receivein_warehouses (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          user_id INTEGER NOT NULL, 
          date   STRING NOT NULL,
          trader_id INTEGER NOT NULL,
          quality TEXT,
          buying_price INTEGER,
          created_at TEXT,
          quantity  INTEGER,
          source  TEXT,
          crop_id INTEGER NOT NULL,
          warehouse_id INTEGER NOT NULL,
          village_id  INTEGER NOT NULL,
          ward_id INTEGER NOT NULL,
          district_id INTEGER NOT NULL,
          region_id INTEGER NOT NULL,
          origin_warehouse TEXT,
          origin_market TEXT,
          cess_payment INTEGER;
          updated_at TEXT,
          )""");
    },
    onUpgrade: (Database db, int oldversion,int newversion)async{
      if (oldversion<newversion) {
        print("Version Upgrade");
      }
    }
    );
    print('db initialize');
    return openDb;
  }

}