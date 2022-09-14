// ignore_for_file: prefer_collection_literals

class Category {
  int? id;
  String? name;
  String? data;

  Category(this.id, this.name, this.data);

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['data'] = data;
    return data;
  }
}
