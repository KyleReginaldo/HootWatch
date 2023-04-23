import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoyo/core/dtos/auth_dto.dart';
import 'package:yoyo/data/model/recent_release_model.dart';
import 'package:yoyo/data/model/search_model.dart';
import 'package:yoyo/data/model/trending_model.dart';
import 'package:yoyo/data/model/upcoming_model.dart';
import 'package:yoyo/data/model/user_model.dart';

import '../../model/info_model.dart';
import '../../model/streamlink_model.dart';

abstract class RemoteDatasource {
  Future<TrendingModel> fetchTrendingAnime();
  Future<RecentReleaseModel> fetchRecentAnime();
  Future<InfoModel> fetchAnimeInfo(String id);
  Future<StreamLinkModel> fetchStreamingLinks(String id);
  Stream<User?> userChanges();
  Future<void> login({required AuthDto authDto});
  Future<void> signup({required AuthDto authDto});
  Future<UpcomingModel> fetchUpcomingAnime();
  Future<UserModel> fetchUser({required String uid});
  Future<void> setupUser({required UserModel user, String? dlUrl});
  Future<void> uploadImage({required String path, required File file});
  Future<String> getDownloadUrl({required String path});
  Future<SearchModel> searchAnime({
    required String query,
    required int limit,
  });
}
