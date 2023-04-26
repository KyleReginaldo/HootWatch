import 'package:get_it/get_it.dart';
import 'package:yoyo/data/datasource/remote/remote_datasource.dart';
import 'package:yoyo/data/datasource/remote/remote_datasource_impl.dart';
import 'package:yoyo/data/repository/repository.dart';
import 'package:yoyo/domain/repository/repository.dart';
import 'package:yoyo/domain/usecases/auth/userchanges.dart';
import 'package:yoyo/domain/usecases/fetch_anime_info.dart';
import 'package:yoyo/domain/usecases/fetch_recent_anime.dart';
import 'package:yoyo/domain/usecases/fetch_stream_links.dart';
import 'package:yoyo/domain/usecases/fetch_trending_anime.dart';
import 'package:yoyo/domain/usecases/fetch_upcoming_anime.dart';
import 'package:yoyo/domain/usecases/firestore/fetch_last_watched.dart';
import 'package:yoyo/domain/usecases/firestore/fetch_user.dart';
import 'package:yoyo/domain/usecases/firestore/save_last_watched.dart';
import 'package:yoyo/domain/usecases/search_anime.dart';
import 'package:yoyo/domain/usecases/storage/get_download_url.dart';
import 'package:yoyo/domain/usecases/storage/upload_image.dart';
import 'package:yoyo/presentation/blocs/search/search_bloc.dart';
import 'package:yoyo/presentation/cubits/auth/authentication/authentication_cubit.dart';
import 'package:yoyo/presentation/cubits/auth/usercheck/usercheck_cubit.dart';
import 'package:yoyo/presentation/cubits/firebase_storage/storage_cubit.dart';
import 'package:yoyo/presentation/cubits/info/info_cubit.dart';
import 'package:yoyo/presentation/cubits/lastWatched/last_watched_cubit.dart';
import 'package:yoyo/presentation/cubits/recent/recent_cubit.dart';
import 'package:yoyo/presentation/cubits/streamlink/streamlink_cubit.dart';
import 'package:yoyo/presentation/cubits/trending/trending_cubit.dart';
import 'package:yoyo/presentation/cubits/upcoming/upcoming_cubit.dart';
import 'package:yoyo/presentation/cubits/user/user_cubit.dart';
import 'package:yoyo/presentation/cubits/user/user_fn/user_fn_cubit.dart';

import 'domain/usecases/auth/login.dart';
import 'domain/usecases/auth/signup.dart';
import 'domain/usecases/firestore/setup_user.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(() => TrendingCubit(sl()));
  sl.registerFactory(() => RecentCubit(sl()));
  sl.registerFactory(() => InfoCubit(sl()));
  sl.registerFactory(() => StreamlinkCubit(sl()));
  sl.registerFactory(() => UsercheckCubit(sl()));
  sl.registerFactory(() => AuthenticationCubit(sl(), sl()));
  sl.registerFactory(() => UpcomingCubit(sl()));
  sl.registerFactory(() => UserCubit(sl()));
  sl.registerFactory(() => UserFnCubit(sl(), sl()));
  sl.registerFactory(() => StorageCubit(sl()));
  sl.registerFactory(() => SearchBloc(sl()));
  sl.registerFactory(() => LastWatchedCubit(sl(), sl()));

  sl.registerLazySingleton(() => FetchTrendingAnime(repo: sl()));
  sl.registerLazySingleton(() => FetchRecentAnime(repo: sl()));
  sl.registerLazySingleton(() => FetchAnimeInfo(repo: sl()));
  sl.registerLazySingleton(() => FetchStreamLinks(repo: sl()));
  sl.registerLazySingleton(() => Userchanges(repo: sl()));
  sl.registerLazySingleton(() => Login(repo: sl()));
  sl.registerLazySingleton(() => Signup(repo: sl()));
  sl.registerLazySingleton(() => FetchUpcomingAnime(repo: sl()));
  sl.registerLazySingleton(() => FetchUser(repo: sl()));
  sl.registerLazySingleton(() => SetupUser(repo: sl()));
  sl.registerLazySingleton(() => UploadImage(repo: sl()));
  sl.registerLazySingleton(() => GetDownloadUrl(repo: sl()));
  sl.registerLazySingleton(() => SearchAnime(repo: sl()));
  sl.registerLazySingleton(() => SaveLastWatched(repo: sl()));
  sl.registerLazySingleton(() => FetchLastWatched(repo: sl()));

  sl.registerLazySingleton<Repository>(() => RepositoryImpl(remote: sl()));
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDsatasourceImpl());
}
