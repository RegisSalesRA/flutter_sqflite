import 'package:flutter_sqlite/data/database.dart';
import 'package:flutter_sqlite/model/musica.dart';

class MusicOperation {
  final dbMusicas = DataBaseFlutterSqlite();

  salvarMusica(Musica musica) async {
    var bancoDados = await dbMusicas.inicializarDB();
    int resultado = await bancoDados.insert("musicas", musica.toJson());
    return resultado;
  }

  recuperarMusicas() async {
    var bancoDados = await dbMusicas.inicializarDB();
    String sql = "SELECT * FROM musicas ORDER BY data DESC ";
    List musicas = await bancoDados.rawQuery(sql);
    return musicas;
  }

  Future<int> atualizarMusica(Musica musica) async {
    var bancoDados = await dbMusicas.inicializarDB();
    return await bancoDados.update("musicas", musica.toJson(),
        where: "id = ?", whereArgs: [musica.id]);
  }

  Future<int> removerMusica(int id) async {
    var bancoDados = await dbMusicas.inicializarDB();
    return await bancoDados.delete("musicas", where: "id = ?", whereArgs: [id]);
  }
}
