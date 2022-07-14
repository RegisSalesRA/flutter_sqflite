import 'package:flutter_sqlite/data/database.dart';
import 'package:flutter_sqlite/model/category.dart';

class CategoryOperation {
  final dbCategory = DataBaseFlutterSqlite();

  salvarCategory(Category category) async {
    var bancoDados = await dbCategory.inicializarDB();
    int resultado = await bancoDados.insert("category", category.toJson());
    return resultado;
  }

  recuperarCategory() async {
    var bancoDados = await dbCategory.inicializarDB();
    String sql = "SELECT * FROM category ORDER BY data DESC ";
    List category = await bancoDados.rawQuery(sql);
    return category;
  }

  Future<int> removerCategory(int id) async {
    var bancoDados = await dbCategory.inicializarDB();
    return await bancoDados
        .delete("category", where: "id = ?", whereArgs: [id]);
  }
}
