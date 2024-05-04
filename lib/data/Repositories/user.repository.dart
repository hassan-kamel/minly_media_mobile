import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/data/models/user/user.dart';
import 'package:minly_media_mobile/data/services/auth.service.dart';
import 'package:minly_media_mobile/data/services/user_shared.service.dart';

class UserRepository {
  final AuthService authService;
  final UserShared userShared;

  UserRepository({required this.authService, required this.userShared});

  Future<dynamic> login(String email, String password) async {
    final loginResponse = await authService.login(email, password);

    // if error
    if (loginResponse?['message'] != null) {
      return {'message': loginResponse?['message']};
    }

    String? token = loginResponse?['token'];
    debugPrint(token);

    if (token != null) userShared.setToken(token);

    dynamic user = loginResponse?['user'];
    return {user: User.fromJson(user), token: token};
  }

  Future<dynamic> signup(String fullName, String email, String password) async {
    final signupResponse = await authService.signup(fullName, email, password);

    // if error
    if (signupResponse?['message'] != null) {
      return {'message': signupResponse?['message']};
    }

    String? token = signupResponse?['token'];
    debugPrint(token);

    if (token != null) userShared.setToken(token);

    dynamic user = signupResponse?['user'];
    return {user: User.fromJson(user), token: token};
  }
}