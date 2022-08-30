// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseFlutterSqlite {
  Database? _db;

  Future<Database>? get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await inicializarDB();
      return _db!;
    }
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "database_flutter_sqflite.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: onCreate);
    return db;
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE music (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title VARCHAR, 
            description TEXT,
            data DATETIME,
            FK_music_category INT,
            FOREIGN KEY (FK_music_category) REFERENCES category (id) 
          )
          ''');

    await db.execute('''
          CREATE TABLE category (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name STRING NOT NULL,
            data DATETIME
          )
          ''');
  }
}
