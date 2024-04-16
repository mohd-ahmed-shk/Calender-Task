import 'package:cheking/using_sqlite/model/calender_model/calender_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CalenderHelper {
  static const int _version = 1;
  static const String _dbName = "calender.db";
  static const String _tableName = "date";

  static const int? columnId = null;
  static const String columnAmount = 'amount';
  static const String columnDate = 'date';
  static const String columnTitle = 'title';
  static const String columnFrequency = 'frequency';
  static const String columnUse = 'use';
  static const String columnBank = 'bank';

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY,
        $columnAmount TEXT NOT NULL,
        $columnDate DATETIME NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnFrequency TEXT NOT NULL,
        $columnUse TEXT NOT NULL,
        $columnBank TEXT NOT NULL
      )
    '''), version: _version);
  }

  static Future<int> addDate(CalenderModel calenderModel) async {
    final db = await _getDB();
    return await db.insert(_tableName, calenderModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<CalenderModel>> getAll() async {
    final db = await _getDB();
    List<Map<String, dynamic>> maps = await db.query(_tableName);

    List<CalenderModel> list =
        maps.map((e) => CalenderModel.fromJson(e)).toList();

    return list;
  }
}
