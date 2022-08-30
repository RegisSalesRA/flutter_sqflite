class Music {
  int? id;
  String? title;
  String? description;
  String? data;
  int? category;

  Music(this.title, this.description, this.data);

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    data = json['data'];
    category = json['FK_music_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['data'] = this.data;
    data['FK_music_category'] = this.category;
    return data;
  }
}
