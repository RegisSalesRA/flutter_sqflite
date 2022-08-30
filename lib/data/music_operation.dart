import 'package:flutter_sqlite/data/database.dart';
import 'package:flutter_sqlite/model/music.dart';

class MusicOperation {
  final dbMusic = DataBaseFlutterSqlite();

  fetchMusics() async {
    var bancoDados = await dbMusic.inicializarDB();
    String sql = "SELECT * FROM music ORDER BY data DESC ";
    List music = await bancoDados.rawQuery(sql);
    return music;
  }

  saveMusic(Music music) async {
    var bancoDados = await dbMusic.inicializarDB();
    int result = await bancoDados.insert("music", music.toJson());
    return result;
  }

  Future<int> updateMusic(Music music) async {
    var dataBase = await dbMusic.inicializarDB();
    return await dataBase.update("music", music.toJson(),
        where: "id = ?", whereArgs: [music.id]);
  }

  Future<int> removerMusica(int id) async {
    var bancoDados = await dbMusic.inicializarDB();
    return await bancoDados.delete("music", where: "id = ?", whereArgs: [id]);
  }
}
