class Music {
  int? id;
  String? title;
  String? description;
  String? data;
  int? category;

  Music({this.id,required this.title,required this.description,required this.data});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    data = json['data'];
    category = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id?.toInt() ?? 0;
    data['title'] = this.title;
    data['description'] = this.description;
    data['data'] = this.data;
    data['categoryId'] = this.category;
    return data;
  }
}
