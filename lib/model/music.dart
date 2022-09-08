class Music {
  int? id;
  String? title;
  String? description;
  String? data;
  Music({
    this.id,
    this.title,
    this.description,
    this.data,
  });

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "data": data,
      };
}

