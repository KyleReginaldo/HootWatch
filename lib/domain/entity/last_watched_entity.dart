// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:yoyo/domain/entity/info_entity.dart';

class LastWatchedEntity {
  final String episodeId;
  final String image;
  final String animeId;
  final List<EpisodeEntity> episodes;
  final String updatedAt;
  final String title;
  final int episodeNumber;
  final ContinueAtEntity continueAt;
  final String duration;
  LastWatchedEntity({
    required this.episodeId,
    required this.image,
    required this.animeId,
    required this.episodes,
    required this.updatedAt,
    required this.title,
    required this.episodeNumber,
    required this.continueAt,
    required this.duration,
  });
}

class ContinueAtEntity {
  final String id;
  final String willContinueAt;
  ContinueAtEntity({
    required this.id,
    required this.willContinueAt,
  });
}
