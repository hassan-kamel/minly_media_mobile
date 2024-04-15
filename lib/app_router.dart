import 'package:go_router/go_router.dart';

import 'presentation/screens/home.dart';
import 'presentation/screens/login.dart';
import 'presentation/screens/signup.dart';

final GoRouter appRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(
            title: "Minly Media",
          )),
  GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
]);
