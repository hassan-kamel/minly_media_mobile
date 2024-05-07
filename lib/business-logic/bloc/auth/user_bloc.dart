import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:minly_media_mobile/data/Repositories/user.repository.dart';
import 'package:minly_media_mobile/data/models/user/user.dart';
import 'package:minly_media_mobile/data/services/auth.service.dart';
import 'package:minly_media_mobile/data/services/user_shared.service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    //  listeners
    on<UserInitialEvent>(_handleInitial);
    on<UserLoginEvent>(_handleLogin);
    on<UserSignupEvent>(_handleSignup);
    on<UserAuthErrorEvent>(_handleAuthError);
    on<UserLogoutEvent>(_handleLogout);
    on<CheckUserIsAuthenticated>(_handleCheckAuth);
  }

  // handlers
  FutureOr<void> _handleLogin(
      UserLoginEvent event, Emitter<UserState> emit) async {
    // loading
    emit(UserGettingAuthenticated());

    // request
    dynamic response = await UserRepository(
            authService: AuthService(), userShared: UserShared())
        .login(event.email, event.password);

    debugPrint("Repo-response ${response.toString()}");

    // fulfilled
    if (response['user'] != null) {
      debugPrint(response.toString());
      emit(UserLoggedIn(
          token: response['token'], user: User.fromJson(response['user'])));
    } else {
      List<String> errors = [];
      if (response['errors'] is List) {
        for (var error in response['errors']) {
          errors.add(error['message'].toString());
        }
      }
      emit(UserLoginError(message: response['message'], errors: errors));
    }
  }

  FutureOr<void> _handleSignup(
      UserSignupEvent event, Emitter<UserState> emit) async {
    // loading
    emit(UserGettingAuthenticated());

    // Request
    dynamic response = await UserRepository(
            authService: AuthService(), userShared: UserShared())
        .signup(event.fullName, event.email, event.password);

    debugPrint("bloc$response");
    // fulfilled
    if (response['user'] != null) {
      emit(UserLoggedIn(
          token: response['token'], user: User.fromJson(response['user'])));
    } else {
      List<String> errors = [];
      if (response['errors'] is List) {
        for (var error in response['errors']) {
          errors.add(error['message'].toString());
        }
      }
      emit(UserLoginError(message: response['message'], errors: errors));
    }
  }

  FutureOr<void> _handleInitial(
      UserInitialEvent event, Emitter<UserState> emit) async {
    emit(UserInitial());
  }

  FutureOr<void> _handleAuthError(
      UserAuthErrorEvent event, Emitter<UserState> emit) async {
    emit(UserLoginError(message: event.message, errors: const []));
  }

  FutureOr<void> _handleLogout(
      UserLogoutEvent event, Emitter<UserState> emit) async {
    emit(UserInitial());
  }

  FutureOr<void> _handleCheckAuth(
      CheckUserIsAuthenticated event, Emitter<UserState> emit) async {
    String? token = await UserRepository(
            authService: AuthService(), userShared: UserShared())
        .getToken();

    debugPrint("token -->$token");

    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      debugPrint("decoded  -->$decodedToken");

      emit(UserLoggedIn(token: token, user: User.fromJson(decodedToken)));
    } else {
      emit(UserInitial());
    }
  }
}
