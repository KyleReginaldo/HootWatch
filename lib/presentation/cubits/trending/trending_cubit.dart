import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo/domain/entity/trending_entity.dart';
import 'package:yoyo/domain/usecases/fetch_trending_anime.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit(this.fetchTrendingAnime) : super(TrendingInitial());
  final FetchTrendingAnime fetchTrendingAnime;

  void onFetchTrendingAnime() async {
    emit(TrendingLoading());
    final either = await fetchTrendingAnime();

    either.fold((l) => emit(TrendingError(msg: l.msg)),
        (r) => emit(TrendingLoaded(trending: r)));
  }
}
