import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
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
                path: '/feeds',
                builder: (context, state) => const FeedsTab(),
              ),
            ],
          ),

          // The route branch for 2º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchTab(),
            ),
          ]),

          // The route branch for 3º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/create-post',
              builder: (context, state) => const CreatePostTab(),
            ),
          ]),

          // The route branch for 4º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/reels',
              builder: (context, state) => const ReelsTab(),
            ),
          ]),

          // The route branch for 5º Tab
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileTab(),
            ),
          ])
        ],
      ),
      GoRoute(
          path: '/auth', builder: (context, state) => const LoginOrRegister()),
    ]);
