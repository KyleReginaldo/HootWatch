// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trending_cubit.dart';

abstract class TrendingState {}

class TrendingInitial extends TrendingState {}

class TrendingLoaded extends TrendingState {
  final TrendingEntity trending;
  TrendingLoaded({
    required this.trending,
  });
}

class TrendingLoading extends TrendingState {}

class TrendingError extends TrendingState {
  final String msg;
  TrendingError({
    required this.msg,
  });
}
