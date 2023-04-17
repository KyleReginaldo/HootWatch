// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yoyo/core/dtos/auth_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoyo/core/error/exception.dart';

import 'package:yoyo/core/error/failure.dart';
import 'package:yoyo/data/datasource/remote/remote_datasource.dart';
import 'package:yoyo/data/model/user_model.dart';
import 'package:yoyo/domain/entity/info_entity.dart';
import 'package:yoyo/domain/entity/recent_release_entity.dart';
import 'package:yoyo/domain/entity/streamlink_entity.dart';
import 'package:yoyo/domain/entity/trending_entity.dart';
import 'package:yoyo/domain/entity/upcoming_entity.dart';
import 'package:yoyo/domain/entity/user_entity.dart';
import 'package:yoyo/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDatasource remote;
  RepositoryImpl({
    required this.remote,
  });
  @override
  Future<Either<Failure, TrendingEntity>> fetchTrendingAnime() async {
    try {
      return Right(await remote.fetchTrendingAnime());
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }

  @override
  Future<Either<Failure, RecentReleaseEntity>> fetchRecentAnime() async {
    try {
      return Right(await remote.fetchRecentAnime());
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }

  @override
  Future<Either<Failure, InfoEntity>> fetchAnimeInfo(String id) async {
    try {
      return Right(await remote.fetchAnimeInfo(id));
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }

  @override
  Future<Either<Failure, StreamLinkEntity>> fetchStreamingLinks(
      String id) async {
    try {
      return Right(await remote.fetchStreamingLinks(id));
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }

  @override
  Future<Either<Failure, void>> login({required AuthDto authDto}) async {
    try {
      await remote.login(authDto: authDto);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(msg: e.message ?? 'invalid user'));
    }
  }

  @override
  Future<Either<Failure, void>> signup({required AuthDto authDto}) async {
    try {
      await remote.signup(authDto: authDto);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(msg: e.message ?? 'invalid user'));
    }
  }

  @override
  Stream<User?> userChanges() => remote.userChanges();

  @override
  Future<Either<Failure, UpcomingEntity>> fetchUpcomingAnime() async {
    try {
      return Right(await remote.fetchUpcomingAnime());
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> fetchUser({required String uid}) async {
    try {
      return Right(await remote.fetchUser(uid: uid));
    } catch (e) {
      return Left(DefaultFailure(msg: '$e'));
    }
  }

  @override
  Future<Either<Failure, void>> setupUser(
      {required UserEntity user, String? dlUrl}) async {
    try {
      await remote.setupUser(user: UserModel.fromE(user), dlUrl: dlUrl);
      return const Right(null);
    } catch (e) {
      return Left(DefaultFailure(msg: '$e'));
    }
  }

  @override
  Future<String> getDownloadUrl({required String path}) async {
    try {
      return await remote.getDownloadUrl(path: path);
    } catch (e) {
      print('download URL: $e');
      rethrow;
    }
  }

  @override
  Future<void> uploadImage({required String path, required File file}) async {
    try {
      await remote.uploadImage(path: path, file: file);
    } catch (e) {
      print('download URL: $e');
    }
  }
}
