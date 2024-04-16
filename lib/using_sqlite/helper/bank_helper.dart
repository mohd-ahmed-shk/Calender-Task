import 'package:cheking/using_sqlite/model/bank_model/bank_model.dart';
import 'package:cheking/using_sqlite/model/use_model/use_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BankHelper {
  static const String _dbName = "bank.db";
  static const int _version = 1;
  static const String _dbTable = "bankList";

  static Future<Database> _getBankDB() async {
    return openDatabase(
        join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'create table $_dbTable (id INTEGER PRIMARY KEY,bank String NOT NULL)'),
        version: _version
    );
  }

  static Future<int> addDateBank(BankModel bankModel) async {
    final db = await _getBankDB();
    return await db.insert(_dbTable, bankModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<BankModel>> getBankAll() async {
    final db = await _getBankDB();
    List<Map<String, dynamic>> maps = await db.query(_dbTable);

    List<BankModel> list =
    maps.map((e) => BankModel.fromJson(e)).toList();

    return list;
  }
}
