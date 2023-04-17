import 'package:yoyo/domain/entity/title_entity.dart';

import '../../data/model/upcoming_model.dart';

class UpcomingEntity {
  UpcomingEntity({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  final int currentPage;
  final bool hasNextPage;
  final List<ResultEntity> results;
}

class ResultEntity {
  ResultEntity({
    required this.id,
    this.malId,
    required this.episode,
    required this.airingAt,
    required this.title,
    required this.country,
    required this.image,
    this.description,
    required this.cover,
    required this.genres,
    required this.color,
    this.rating,
    this.releaseDate,
    required this.type,
  });

  final String id;
  final int? malId;
  final int episode;
  final int airingAt;
  final TitleEntity title;
  final Country country;
  final String image;
  final String? description;
  final String cover;
  final List<Genre> genres;
  final String color;
  final int? rating;
  final int? releaseDate;
  final Type type;
}
