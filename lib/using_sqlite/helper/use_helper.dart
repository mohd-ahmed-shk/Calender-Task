import 'package:cheking/using_sqlite/model/use_model/use_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UseHelper {
  static const String _dbName = "use.db";
  static const int _version = 1;
  static const String _dbTable = "useList";

  static Future<Database> _getUseDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
          'create table $_dbTable (id INTEGER PRIMARY KEY,use String NOT NULL)'),
    version: _version
    );
  }

  static Future<int> addDateUse(UseModel useModel) async {
    final db = await _getUseDB();
    return await db.insert(_dbTable, useModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<UseModel>> getUseAll() async {
    final db = await _getUseDB();
    List<Map<String, dynamic>> maps = await db.query(_dbTable);

    List<UseModel> list =
    maps.map((e) => UseModel.fromJson(e)).toList();

    return list;
  }
}
