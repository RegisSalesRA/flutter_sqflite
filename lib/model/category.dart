class Category {
  int? id;
  String? name;
  String? data;

  Category({this.id, this.name, this.data});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["id"], name: json["name"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "data": data,
      };
}
