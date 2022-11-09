class Music {
  int? id;
  String? name;
  String? description;
  int? categoryId;
  int? albumId;
  String? data;
  Music({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.albumId,
    this.data,
  });

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        categoryId: json["categoryId"],
        albumId: json["albumId"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "categoryId": categoryId,
        "albumId": albumId,
        "data": data,
      };
}
