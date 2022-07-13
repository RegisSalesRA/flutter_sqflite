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


class Musica {
  int? id;
  String? nome;
  String? descricao;
  String? data;

  Musica({this.id, this.nome, this.descricao, this.data});

  Musica.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['data'] = this.data;
    return data;
  }
}
