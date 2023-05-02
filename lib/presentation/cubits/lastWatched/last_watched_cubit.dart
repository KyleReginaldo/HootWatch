import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo/domain/entity/last_watched_entity.dart';
import 'package:yoyo/domain/usecases/firestore/fetch_last_watched.dart';

import '../../../domain/usecases/firestore/save_last_watched.dart';

part 'last_watched_state.dart';

class LastWatchedCubit extends Cubit<LastWatchedState> {
  LastWatchedCubit(this.saveLastWatched, this.fetchLastWatched)
      : super(LastWatchedInitial());

  final SaveLastWatched saveLastWatched;
  final FetchLastWatched fetchLastWatched;

  Future<void> onSaveLastWatched(
      {required String userId, required LastWatchedEntity info}) async {
    final either = await saveLastWatched(userId: userId, info: info);
    either.fold((l) {
      emit(LastWatchedError());
    }, (r) => null);
  }

  void onFetchLastWatched({required String userId}) async {
    emit(LastWatchedLoading());
    final either = await fetchLastWatched(userId: userId);
    either.fold((l) => emit(LastWatchedError()),
        (r) => emit(LastWatchedLoaded(animes: r)));
  }
}
