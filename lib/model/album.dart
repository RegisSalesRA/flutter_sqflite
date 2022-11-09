class Album {
  int? id;
  String? name;
  String? data;

  Album({this.id, this.name, this.data});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(id: json["id"], name: json["name"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "data": data,
      };
}
