import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minly_media_mobile/app_router.dart';
import 'package:minly_media_mobile/business-logic/bloc/auth/user_bloc.dart';
import 'package:minly_media_mobile/business-logic/bloc/post/post_bloc.dart';

void main() {
  runApp(const MinlyMediaApp());
}

class MinlyMediaApp extends StatelessWidget {
  const MinlyMediaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (BuildContext context) => PostsBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
      ],
      child: MaterialApp.router(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        // Set the routes
        routerConfig: appRouter,
        title: 'Minly Media',
        // Set the theme
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(185, 12, 194, 164)),
          useMaterial3: true,
        ),
      ),
    );
  }
}
