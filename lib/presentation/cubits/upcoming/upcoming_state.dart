part of 'upcoming_cubit.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object> get props => [];
}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoaded extends UpcomingState {
  final UpcomingEntity upcoming;
  const UpcomingLoaded({
    required this.upcoming,
  });
}

class UpcomingLoading extends UpcomingState {}

class UpcomingError extends UpcomingState {
  final String msg;
  const UpcomingError({
    required this.msg,
  });
}
