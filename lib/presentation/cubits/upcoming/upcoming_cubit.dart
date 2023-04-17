// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/upcoming_entity.dart';
import '../../../domain/usecases/fetch_upcoming_anime.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit(
    this.fetchUpcomingAnime,
  ) : super(UpcomingInitial());
  final FetchUpcomingAnime fetchUpcomingAnime;

  void onFetchUpcomingAnime() async {
    emit(UpcomingLoading());
    final either = await fetchUpcomingAnime();
    either.fold((l) => emit(UpcomingError(msg: l.msg)),
        (r) => emit(UpcomingLoaded(upcoming: r)));
  }
}
