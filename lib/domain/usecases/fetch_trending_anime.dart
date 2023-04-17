// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:yoyo/domain/repository/repository.dart';

import '../../core/error/failure.dart';
import '../entity/trending_entity.dart';

class FetchTrendingAnime {
  final Repository repo;
  FetchTrendingAnime({
    required this.repo,
  });

  Future<Either<Failure, TrendingEntity>> call() async {
    return await repo.fetchTrendingAnime();
  }
}
