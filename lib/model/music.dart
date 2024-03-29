class Music {
  int? id;
  String? name;
  String? description;
  String? lyric;
  int? isFavorite;
  int? categoryId;
  int? albumId;
  String? data;
  Music({
    this.id,
    this.name,
    this.description,
    this.lyric,
    this.isFavorite,
    this.categoryId,
    this.albumId,
    this.data,
  });

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        lyric: json["lyric"],
        isFavorite: json["isFavorite"],
        categoryId: json["categoryId"],
        albumId: json["albumId"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "lyric": lyric,
        "isFavorite": isFavorite,
        "categoryId": categoryId,
        "albumId": albumId,
        "data": data,
      };
}
