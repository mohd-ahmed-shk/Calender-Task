
import 'package:cheking/learning_sqlite/coding_orbit/model/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelpers {
  static const int _version = 1;
  static const String _dbName = "Notes.db";
  static const String _tableName = "Note";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL)"),
        version: _version);
  }

  static Future<int> addNote(Notes note) async {
    final db = await _getDB();
    return await db.insert('Note', note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> update(Notes note) async {
    final db = await _getDB();
    return await db.update('Note', note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> delete(Notes note) async {
    final db = await _getDB();
    return await db.delete('Note', where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<Notes>?> getAllNotes() async {
    final db = await _getDB();
    List<Map<String,dynamic>> maps = await db.query('Note');

    // List<Notes> list = maps.map((e) => Notes.fromJson(e)).toList();
    if(maps.isEmpty) {
      return null;
    }
    var list = List.generate(maps.length, (index) => Notes.fromJson(maps[index]));

    print("++++++++++++++++++$list+++++++++++++++++++++++++");
    return list;
  }


}
