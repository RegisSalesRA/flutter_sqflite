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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['data'] = this.data;
    return data;
  }
}
