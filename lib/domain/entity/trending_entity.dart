import '../../data/model/trending_model.dart';
import 'title_entity.dart';

class TrendingEntity {
  TrendingEntity({
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
    required this.title,
    required this.image,
    required this.trailer,
    required this.description,
    required this.status,
    required this.cover,
    this.rating,
    this.releaseDate,
    this.color,
    required this.genres,
    this.totalEpisodes,
    this.duration,
    required this.type,
  });

  final String id;
  final int? malId;
  final TitleEntity title;
  final String image;
  final TrailerEntity trailer;
  final String description;
  final Status status;
  final String cover;
  final int? rating;
  final int? releaseDate;
  final String? color;
  final List<String> genres;
  final int? totalEpisodes;
  final int? duration;
  final Type type;
}

class TrailerEntity {
  TrailerEntity({
    this.id,
    this.site,
    this.thumbnail,
  });

  final String? id;
  final String? site;
  final String? thumbnail;
}
