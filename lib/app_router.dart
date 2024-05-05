import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minly_media_mobile/business-logic/bloc/auth/user_bloc.dart';
import 'package:minly_media_mobile/presentation/screens/signin_or_signup.dart';

import 'presentation/screens/home_tabs/create_post.dart';
import 'presentation/screens/home_tabs/feeds.dart';
import 'presentation/screens/home_tabs/profile.dart';
import 'presentation/screens/home_tabs/reels.dart';
import 'presentation/screens/home_tabs/search.dart';
import 'presentation/screens/home.dart';

// Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
    routes: <RouteBase>[
      // Home Tabs
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomePage(navigationShell: navigationShell);
        },
        branches: [
          // The route branch for the 1º Tab
          StatefulShellBranch(
            initialLocation: '/feeds',
            navigatorKey: _sectionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                redirect: _redirectForHome,
                path: '/feeds',
                builder: (context, state) => const FeedsTab(),
              ),
            ],
          ),

          // The route branch for 2º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              redirect: _redirectForHome,
              path: '/search',
              builder: (context, state) => const SearchTab(),
            ),
          ]),

          // The route branch for 3º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              redirect: _redirectForHome,
              path: '/create-post',
              builder: (context, state) => const CreatePostTab(),
            ),
          ]),

          // The route branch for 4º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              redirect: _redirectForHome,
              path: '/reels',
              builder: (context, state) => const ReelsTab(),
            ),
          ]),

          // The route branch for 5º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              redirect: _redirectForHome,
              path: '/profile',
              builder: (context, state) => const ProfileTab(),
            ),
          ])
        ],
      ),

      // Login or Register
      GoRoute(
        redirect: (BuildContext context, GoRouterState state) {
          BlocProvider.of<UserBloc>(context).add(CheckUserIsAuthenticated());

          UserState authState = BlocProvider.of<UserBloc>(context).state;
          if (authState is UserLoggedIn) {
            return '/feeds';
          } else {
            return null;
          }
        },
        path: '/auth',
        builder: (context, state) => const LoginOrRegister(),
      )
    ]);

String? _redirectForHome(BuildContext context, GoRouterState state) {
  BlocProvider.of<UserBloc>(context).add(CheckUserIsAuthenticated());

  UserState authState = BlocProvider.of<UserBloc>(context).state;
  if (authState is! UserLoggedIn) {
    return '/auth';
  } else {
    return null;
  }
}
