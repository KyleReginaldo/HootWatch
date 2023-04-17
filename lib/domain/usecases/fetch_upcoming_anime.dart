// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:yoyo/domain/repository/repository.dart';

import '../../core/error/failure.dart';
import '../entity/upcoming_entity.dart';

class FetchUpcomingAnime {
  final Repository repo;
  FetchUpcomingAnime({
    required this.repo,
  });
  Future<Either<Failure, UpcomingEntity>> call() async {
    return await repo.fetchUpcomingAnime();
  }
}
