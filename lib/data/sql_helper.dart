import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/musica.dart';

class DataBaseFlutterSqlite {
  static final DataBaseFlutterSqlite _databasefluttersqlite =
      DataBaseFlutterSqlite._internal();

  Database? _db;

  factory DataBaseFlutterSqlite() {
    return _databasefluttersqlite;
  }

  DataBaseFlutterSqlite._internal() {}

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
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

  Future<int> salvarMusica(Musica musica) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert("musicas", musica.toMap());
    return resultado;
  }

  recuperarMusicas() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM musicas ORDER BY data DESC ";
    List musicas = await bancoDados.rawQuery(sql);
    return musicas;
  }

  Future<int> atualizarMusica(Musica musica) async {
    var bancoDados = await db;
    return await bancoDados.update("musicas", musica.toMap(),
        where: "id = ?", whereArgs: [musica.id]);
  }

  Future<int> removerMusica(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete("musicas", where: "id = ?", whereArgs: [id]);
  }
}
