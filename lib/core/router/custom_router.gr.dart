// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'custom_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    InfoRoute.name: (routeData) {
      final args = routeData.argsAs<InfoRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: InfoScreen(
          key: args.key,
          id: args.id,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StreamingRoute.name: (routeData) {
      final args = routeData.argsAs<StreamingRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: StreamingScreen(
          key: args.key,
          id: args.id,
          episodes: args.episodes,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignupRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SignupScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () => const EditProfileRouteArgs());
      return CustomPage<dynamic>(
        routeData: routeData,
        child: EditProfileScreen(
          key: args.key,
          user: args.user,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          AuthRoute.name,
          path: '/',
        ),
        RouteConfig(
          InfoRoute.name,
          path: '/info-screen',
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main-screen',
        ),
        RouteConfig(
          StreamingRoute.name,
          path: '/streaming-screen',
        ),
        RouteConfig(
          SignupRoute.name,
          path: '/signup-screen',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login-screen',
        ),
        RouteConfig(
          EditProfileRoute.name,
          path: '/edit-profile-screen',
        ),
      ];
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: '/',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [InfoScreen]
class InfoRoute extends PageRouteInfo<InfoRouteArgs> {
  InfoRoute({
    Key? key,
    required String id,
  }) : super(
          InfoRoute.name,
          path: '/info-screen',
          args: InfoRouteArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'InfoRoute';
}

class InfoRouteArgs {
  const InfoRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'InfoRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/main-screen',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [StreamingScreen]
class StreamingRoute extends PageRouteInfo<StreamingRouteArgs> {
  StreamingRoute({
    Key? key,
    required String id,
    required List<EpisodeEntity> episodes,
  }) : super(
          StreamingRoute.name,
          path: '/streaming-screen',
          args: StreamingRouteArgs(
            key: key,
            id: id,
            episodes: episodes,
          ),
        );

  static const String name = 'StreamingRoute';
}

class StreamingRouteArgs {
  const StreamingRouteArgs({
    this.key,
    required this.id,
    required this.episodes,
  });

  final Key? key;

  final String id;

  final List<EpisodeEntity> episodes;

  @override
  String toString() {
    return 'StreamingRouteArgs{key: $key, id: $id, episodes: $episodes}';
  }
}

/// generated route for
/// [SignupScreen]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup-screen',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    UserEntity? user,
  }) : super(
          EditProfileRoute.name,
          path: '/edit-profile-screen',
          args: EditProfileRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'EditProfileRoute';
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    this.user,
  });

  final Key? key;

  final UserEntity? user;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, user: $user}';
  }
}
