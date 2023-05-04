import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yoyo/presentation/screens/auth/login_screen.dart';
import 'package:yoyo/presentation/screens/extension/edit_profile_screen.dart';
import 'package:yoyo/presentation/screens/extension/info_screen.dart';
import 'package:yoyo/presentation/screens/extension/streaming_screen.dart';
import 'package:yoyo/presentation/screens/main_screen.dart';

import '../../domain/entity/info_entity.dart';
import '../../domain/entity/last_watched_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/extension/account_screen.dart';
part 'custom_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: AuthScreen,
      initial: true,
    ),
    AutoRoute(
      page: InfoScreen,
      // transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    AutoRoute(
      page: MainScreen,
    ),
    AutoRoute(
      page: StreamingScreen,
      // transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    AutoRoute(
      page: SignupScreen,
      // transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    AutoRoute(
      page: LoginScreen,
      // transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    AutoRoute(
      page: AccountScreen,
      // transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    AutoRoute(
      page: EditProfileScreen,
      // transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
