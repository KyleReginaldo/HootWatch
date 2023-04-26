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

  void onSaveLastWatched(
      {required String userId, required LastWatchedEntity info}) async {
    print('before function');
    final either = await saveLastWatched(userId: userId, info: info);
    print('after function');
    either.fold((l) {
      print('error nananaman  ${l.msg}');
      emit(LastWatchedError());
    }, (r) => print('success[[[-0dsadek4k1234210-]]]'));
    print('after2 function');
  }

  void onFetchLastWatched({required String userId}) async {
    emit(LastWatchedLoading());
    final either = await fetchLastWatched(userId: userId);
    either.fold((l) => emit(LastWatchedError()),
        (r) => emit(LastWatchedLoaded(animes: r)));
  }
}
