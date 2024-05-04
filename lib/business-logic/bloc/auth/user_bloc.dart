import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

    // fulfilled
    if (response['user'] != null) {
      debugPrint(response.toString());
      emit(UserLoggedIn(
          token: response['token'], user: User.fromJson(response['user'])));
    } else {
      emit(UserLoginError(message: response['message']));
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

    debugPrint("bloc" + response.toString());
    // fulfilled
    if (response['user'] != null) {
      emit(UserLoggedIn(
          token: response['token'], user: User.fromJson(response['user'])));
    } else {
      emit(UserLoginError(message: response['message']));
    }
  }

  FutureOr<void> _handleInitial(
      UserInitialEvent event, Emitter<UserState> emit) async {
    emit(UserInitial());
  }

  FutureOr<void> _handleAuthError(
      UserAuthErrorEvent event, Emitter<UserState> emit) async {
    emit(UserLoginError(message: event.message));
  }

  FutureOr<void> _handleLogout(
      UserLogoutEvent event, Emitter<UserState> emit) async {
    emit(UserInitial());
  }
}
