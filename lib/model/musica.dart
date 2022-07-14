class Musica {
  int? id;
  String? titulo;
  String? descricao;
  String? data;
  int? category;

  Musica(this.titulo, this.descricao, this.data);

  Musica.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    data = json['data'];
    category = json['FK_musicas_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['data'] = this.data;
    data['FK_musicas_category'] = this.category;
    return data;
  }
}
