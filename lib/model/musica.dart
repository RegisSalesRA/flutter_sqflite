class Musica {
  int? id;
  String? titulo;
  String? descricao;
  String? data;

  Musica(this.titulo, this.descricao, this.data);

  Musica.fromMap(Map map) {
    id = map["id"];
    titulo = map["titulo"];
    descricao = map["descricao"];
    data = map["data"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "titulo": titulo,
      "descricao": descricao,
      "data": data,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}
