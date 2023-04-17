import 'package:yoyo/domain/entity/recent_release_entity.dart';

import 'title_model.dart';

class RecentReleaseModel extends RecentReleaseEntity {
  RecentReleaseModel(
      {required super.currentPage,
      required super.hasNextPage,
      required super.totalPages,
      required super.totalResults,
      required super.results});

  factory RecentReleaseModel.fromMap(Map<String, dynamic> json) =>
      RecentReleaseModel(
        currentPage: json["currentPage"],
        hasNextPage: json["hasNextPage"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
        results: List<ResultModel>.from(
            json["results"].map((x) => ResultModel.fromMap(x))),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    required super.id,
    required super.malId,
    required super.title,
    required super.image,
    super.rating,
    super.color,
    required super.episodeId,
    required super.episodeTitle,
    required super.episodeNumber,
    required super.genres,
    required super.type,
  });
  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        malId: json["malId"],
        title: TitleModel.fromMap(json["title"]),
        image: json["image"],
        rating: json["rating"],
        color: json["color"],
        episodeId: json["episodeId"],
        episodeTitle: json["episodeTitle"],
        episodeNumber: json["episodeNumber"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        type: typeValues.map[json["type"]]!,
      );
}

enum Types { TV, ONA }

final typeValues = EnumValues({"ONA": Types.ONA, "TV": Types.TV});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
