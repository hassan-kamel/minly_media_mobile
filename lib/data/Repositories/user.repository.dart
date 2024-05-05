import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/data/services/auth.service.dart';
import 'package:minly_media_mobile/data/services/user_shared.service.dart';

class UserRepository {
  final AuthService authService;
  final UserShared userShared;

  UserRepository({required this.authService, required this.userShared});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final loginResponse = await authService.login(email, password);

    // if error
    if (loginResponse?['message'] != null) {
      return {
        'message': loginResponse?['message'],
        'errors': loginResponse?['errors']
      };
    }

    String? token = loginResponse?['token'];
    debugPrint(token);

    debugPrint("loginResponse ${loginResponse.toString()}");

    if (token != null) userShared.setToken(token);

    Map<String, dynamic>? user = loginResponse?['user'];

    debugPrint("Repo-user ${user.toString()}");
    return {'user': user, 'token': token};
  }

  Future<Map<String, dynamic>> signup(
      String fullName, String email, String password) async {
    final signupResponse = await authService.signup(fullName, email, password);

    // if error
    if (signupResponse?['message'] != null) {
      return {
        'message': signupResponse?['message'],
        'errors': signupResponse?['errors']
      };
    }

    String? token = signupResponse?['token'];
    debugPrint(token);

    if (token != null) userShared.setToken(token);

    dynamic user = signupResponse?['user'];

    return {'user': user, 'token': token};
  }

  Future<String?> getToken() async => await userShared.getToken();

  void setToken(String token) => userShared.setToken(token);
}
