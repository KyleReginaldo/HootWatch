import 'package:yoyo/data/model/title_model.dart';
import 'package:yoyo/domain/entity/upcoming_entity.dart';

class UpcomingModel extends UpcomingEntity {
  UpcomingModel(
      {required super.currentPage,
      required super.hasNextPage,
      required super.results});

  factory UpcomingModel.fromMap(Map<String, dynamic> json) => UpcomingModel(
        currentPage: json["currentPage"],
        hasNextPage: json["hasNextPage"],
        results: List<ResultModel>.from(
            json["results"].map((x) => ResultModel.fromMap(x))),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    required super.id,
    super.malId,
    required super.episode,
    required super.airingAt,
    required super.title,
    required super.country,
    required super.image,
    super.description,
    required super.cover,
    required super.genres,
    required super.color,
    super.rating,
    super.releaseDate,
    required super.type,
  });

  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        malId: json["malId"],
        episode: json["episode"],
        airingAt: json["airingAt"],
        title: TitleModel.fromMap(json["title"]),
        country: countryValues.map[json["country"]] ?? Country.UNKNOWN,
        image: json["image"],
        description: json["description"],
        cover: json["cover"],
        genres: List<Genre>.from(
            json["genres"].map((x) => genreValues.map[x] ?? Genre.UNKNOWN)),
        color: json["color"],
        rating: json["rating"],
        releaseDate: json["releaseDate"],
        type: typeValues.map[json["type"]] ?? Type.UNKNOWN,
      );
}

enum Country {
  CN,
  JP,
  UNKNOWN,
}

final countryValues = EnumValues({
  "CN": Country.CN,
  "JP": Country.JP,
  "UNKNOWN": Country.UNKNOWN,
});

enum Genre {
  ACTION,
  ADVENTURE,
  FANTASY,
  COMEDY,
  UNKNOWN,
}

final genreValues = EnumValues({
  "Action": Genre.ACTION,
  "Adventure": Genre.ADVENTURE,
  "Comedy": Genre.COMEDY,
  "Fantasy": Genre.FANTASY,
  "UNKNOWN": Genre.UNKNOWN,
});

enum Type {
  ONA,
  TV,
  UNKNOWN,
}

final typeValues = EnumValues({
  "ONA": Type.ONA,
  "TV": Type.TV,
  "UNKNOWN": Type.UNKNOWN,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
