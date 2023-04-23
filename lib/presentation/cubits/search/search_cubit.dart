import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoyo/domain/entity/search_entity.dart';

import '../../../domain/usecases/search_anime.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchAnime) : super(SearchInitial());

  final SearchAnime searchAnime;

  void onSeachAnime({
    required String query,
    required int limit,
    required bool canLoad,
  }) async {
    if (canLoad) emit(SearchLoading());
    final either = await searchAnime(query: query, limit: limit);
    either.fold((l) => emit(SearchError(msg: l.msg)),
        (r) => emit(SearchLoaded(search: r)));
  }
}
