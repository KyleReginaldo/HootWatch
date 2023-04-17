import 'package:yoyo/domain/entity/trending_entity.dart';

import 'title_model.dart';

class TrendingModel extends TrendingEntity {
  TrendingModel(
      {required super.currentPage,
      required super.hasNextPage,
      required super.results});
  factory TrendingModel.fromMap(Map<String, dynamic> json) => TrendingModel(
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
    required super.title,
    required super.image,
    required super.trailer,
    required super.description,
    required super.status,
    required super.cover,
    super.rating,
    super.releaseDate,
    super.color,
    required super.genres,
    super.totalEpisodes,
    super.duration,
    required super.type,
  });
  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        malId: json["malId"],
        title: TitleModel.fromMap(json["title"]),
        image: json["image"],
        trailer: TrailerModel.fromMap(json["trailer"]),
        description: json["description"],
        status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
        cover: json["cover"],
        rating: json["rating"],
        releaseDate: json["releaseDate"],
        color: json["color"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        totalEpisodes: json["totalEpisodes"],
        duration: json["duration"] ?? 0,
        type: typeValues.map[json["type"]] ?? Type.UNKNOWN,
      );
}

enum Status { ONGOING, NOT_YET_AIRED, UNKNOWN }

final statusValues = EnumValues({
  "Not yet aired": Status.NOT_YET_AIRED,
  "Ongoing": Status.ONGOING,
  "UNKNOWN": Status.UNKNOWN,
});

class TrailerModel extends TrailerEntity {
  TrailerModel({
    super.id,
    super.site,
    super.thumbnail,
  });
  factory TrailerModel.fromMap(Map<String, dynamic> json) => TrailerModel(
        id: json["id"],
        site: json["site"],
        thumbnail: json["thumbnail"],
      );
}

enum Type { TV, UNKNOWN }

final typeValues = EnumValues({"TV": Type.TV, "UNKNOWN": Type.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
