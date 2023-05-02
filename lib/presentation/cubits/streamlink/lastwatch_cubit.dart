// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yoyo/domain/entity/last_watched_entity.dart';
import 'package:yoyo/domain/usecases/firestore/check_lastwatch.dart';

class LastwatchCubit extends Cubit<LastWatchedEntity?> {
  LastwatchCubit(
    this.checkLastwatch,
  ) : super(null);
  final CheckLastwatch checkLastwatch;

  void onCheckLastWatch({
    required String userId,
    required String animeId,
  }) async {
    final lastWatch = await checkLastwatch(userId: userId, animeId: animeId);
    emit(lastWatch);
  }
}
