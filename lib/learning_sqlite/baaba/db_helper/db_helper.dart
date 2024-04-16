import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const dbName = 'myDatabase.db';
  static const dbVersion = 1;

  static const dbTable = 'myTable';
  static const columnId = 'id';
  static const columnName = 'name';


  // constructor
  static final DBHelper instance = DBHelper();

  // initialization the db
  static Database? _database;


  Future<Database?> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database!;
  }


  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,dbName);
    return await openDatabase(path,version: dbVersion,onCreate: onCreate);

  }

  Future onCreate(Database db, int version) async {
    db.execute(
      '''
      CREATE TABLE $dbTable (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL
      )
      '''
    );
  }

  insertRecord(Map<String,dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

  Future<List<Map<String,dynamic>>> queryRecord() async {
    Database? db = await instance.database;
    return db!.query(dbTable);
  }

  Future<int> updateRecord(Map<String,dynamic> row) async {
    Database? db = await instance.database;
    int id  = row[columnId];
    return db!.update(dbTable, row,where: '$columnId = ?',whereArgs: [id]);
  }

  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;

    return db!.delete(dbTable,where: '$columnId = ?',whereArgs: [id]);
  }



}