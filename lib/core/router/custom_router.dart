import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yoyo/presentation/screens/auth/login_screen.dart';
import 'package:yoyo/presentation/screens/extension/edit_profile_screen.dart';
import 'package:yoyo/presentation/screens/extension/info_screen.dart';
import 'package:yoyo/presentation/screens/extension/streaming_screen.dart';
import 'package:yoyo/presentation/screens/main_screen.dart';

import '../../domain/entity/info_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
part 'custom_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    CustomRoute(
      page: AuthScreen,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: InfoScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: MainScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: StreamingScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: SignupScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: LoginScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: EditProfileScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
