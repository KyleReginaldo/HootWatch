import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  PlayingCubit() : super(const PlayingState());

  void addGivenId(String id) => emit(state.copyWith(givenId: id));
  void addRootId(String id) => emit(state.copyWith(rootId: id));

  void checkIfPlaying(String givenId) {
    emit(state.copyWith(playing: state.givenId == state.rootId));
  }
}
