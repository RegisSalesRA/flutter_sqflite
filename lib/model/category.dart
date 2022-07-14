class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    this.id = json['categoryId'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
