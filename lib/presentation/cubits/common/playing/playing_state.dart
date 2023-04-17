// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'playing_cubit.dart';

class PlayingState extends Equatable {
  final String? rootId;
  final String? givenId;
  final bool? playing;
  const PlayingState({
    this.rootId,
    this.givenId,
    this.playing,
  });

  @override
  List<Object> get props => [];

  PlayingState copyWith({
    String? rootId,
    String? givenId,
    bool? playing,
  }) {
    return PlayingState(
      rootId: rootId ?? this.rootId,
      givenId: givenId ?? this.givenId,
      playing: playing ?? this.playing,
    );
  }
}
