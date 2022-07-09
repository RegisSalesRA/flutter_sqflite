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

  _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE musicas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
           titulo VARCHAR, 
         descricao TEXT,
        data DATETIME
          )
          ''');
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_minhas_musicas.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }
}
