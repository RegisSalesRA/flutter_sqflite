import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/musica.dart';

class DataBaseFlutterSqlite {
  static final String nameTable = "musicas";
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
    /*

    id titulo descricao data
    01 teste  teste     02/10/2020

    * */

    String sql = "CREATE TABLE $nameTable ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, "
        "descricao TEXT, "
        "data DATETIME)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
        join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarAnotacao(Musica anotacao) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nameTable, anotacao.toMap());
    return resultado;
  }

  recuperarMusicas() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nameTable ORDER BY data DESC ";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }
}
