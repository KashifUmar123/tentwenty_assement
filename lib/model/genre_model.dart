class GenresModel {
  List<Genres> genres;

  GenresModel({required this.genres});

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      genres: List.from(json['genres'].map((e) => Genres.fromJson(e))),
    );
  }
}

class Genres {
  int id;
  String name;
  String imagePath;

  Genres({required this.id, required this.name, this.imagePath = ""});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }
}
