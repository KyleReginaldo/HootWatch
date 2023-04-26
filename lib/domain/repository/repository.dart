import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoyo/core/error/failure.dart';
import 'package:yoyo/domain/entity/info_entity.dart';
import 'package:yoyo/domain/entity/last_watched_entity.dart';
import 'package:yoyo/domain/entity/recent_release_entity.dart';
import 'package:yoyo/domain/entity/search_entity.dart';
import 'package:yoyo/domain/entity/streamlink_entity.dart';
import 'package:yoyo/domain/entity/trending_entity.dart';
import 'package:yoyo/domain/entity/upcoming_entity.dart';
import 'package:yoyo/domain/entity/user_entity.dart';

import '../../core/dtos/auth_dto.dart';

abstract class Repository {
  Future<Either<Failure, TrendingEntity>> fetchTrendingAnime();
  Future<Either<Failure, RecentReleaseEntity>> fetchRecentAnime();
  Future<Either<Failure, InfoEntity>> fetchAnimeInfo(String id);
  Future<Either<Failure, StreamLinkEntity>> fetchStreamingLinks(String id);
  Stream<User?> userChanges();
  Future<Either<Failure, void>> login({required AuthDto authDto});
  Future<Either<Failure, void>> signup({required AuthDto authDto});
  Future<Either<Failure, UpcomingEntity>> fetchUpcomingAnime();
  Future<Either<Failure, UserEntity>> fetchUser({required String uid});
  Future<Either<Failure, void>> setupUser(
      {required UserEntity user, String? dlUrl});
  Future<void> uploadImage({required String path, required File file});
  Future<String> getDownloadUrl({required String path});
  Future<Either<Failure, SearchEntity>> searchAnime({
    required String query,
    required int limit,
  });
  Future<Either<Failure, void>> saveLastWatched(
      {required String userId, required LastWatchedEntity info});
  Future<Either<Failure, List<LastWatchedEntity>>> fetchLastWatched(
      {required String userId});
}
