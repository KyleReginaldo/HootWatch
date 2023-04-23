import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/dependency.dart';
import 'package:yoyo/presentation/blocs/search/search_bloc.dart';
import 'package:yoyo/presentation/cubits/auth/authentication/authentication_cubit.dart';
import 'package:yoyo/presentation/cubits/auth/usercheck/usercheck_cubit.dart';
import 'package:yoyo/presentation/cubits/common/bnb_cubit.dart';
import 'package:yoyo/presentation/cubits/common/episodes/episodes_cubit.dart';
import 'package:yoyo/presentation/cubits/common/fullscreen_cubit.dart';
import 'package:yoyo/presentation/cubits/common/playing_cubit.dart';
import 'package:yoyo/presentation/cubits/common/searchbar_cubit.dart';
import 'package:yoyo/presentation/cubits/image/image_cubit.dart';
import 'package:yoyo/presentation/cubits/firebase_storage/storage_cubit.dart';
import 'package:yoyo/presentation/cubits/info/info_cubit.dart';
import 'package:yoyo/presentation/cubits/recent/recent_cubit.dart';
import 'package:yoyo/presentation/cubits/streamlink/streamlink_cubit.dart';
import 'package:yoyo/presentation/cubits/trending/trending_cubit.dart';
import 'package:yoyo/presentation/cubits/upcoming/upcoming_cubit.dart';
import 'package:yoyo/presentation/cubits/user/user_cubit.dart';
import 'package:yoyo/presentation/cubits/user/user_fn/user_fn_cubit.dart';

import 'core/constants/constant.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TrendingCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<RecentCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<InfoCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<StreamlinkCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UsercheckCubit>()..checkUserchanges(),
        ),
        BlocProvider(
          create: (context) => sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UpcomingCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UserFnCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<StorageCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => SearchbarCubit(),
        ),
        BlocProvider(
          create: (context) => BnbCubit(),
        ),
        BlocProvider(
          create: (context) => FullscreenCubit(),
        ),
        BlocProvider(
          create: (context) => EpisodesCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => PlayingCubit(),
        ),
      ],
      child: ResponsiveSizer(builder: (p0, p1, p2) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          title: 'Funime',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: kTransparentColor,
            ),
            scaffoldBackgroundColor: kScaffoldBgColor,
            textTheme: kTextTheme,
            brightness: Brightness.dark,
            useMaterial3: true,
            primaryColor: kPrimaryColor,
            fontFamily: 'Lato',
            secondaryHeaderColor: kSecondaryColor,
            listTileTheme: const ListTileThemeData(
              iconColor: kGreyColor,
            ),
          ),
        );
      }),
    );
  }
}
