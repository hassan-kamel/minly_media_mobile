import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/constants/strings.dart';
import 'package:minly_media_mobile/data/models/user/user.dart';
import 'package:minly_media_mobile/utils/error_interceptor.dart';

class AuthService {
  late Dio dio;

  // initialize the post service
  AuthService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseAPIUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      validateStatus: (int? status) {
        return status != null;
        // return status != null && status >= 200 && status < 300;
      },
    );
    dio = Dio(options);

    dio.interceptors.addAll([
      ErrorInterceptor(),
    ]);
  }

  // login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final data = User(email: email, password: password).toJsonForLogin();

    try {
      Response response = await dio.post('/auth/login',
          data: data,
          options: Options(
            headers: {
              Headers.contentTypeHeader: 'application/json',
              Headers.acceptHeader: 'application/json',
            },
          ));

      return jsonDecode(response.toString());
    } catch (e) {
      return null;
    }
  }

  // signup
  Future<Map<String, dynamic>?> signup(
      String fullName, String email, String password) async {
    final data = User(fullName: fullName, email: email, password: password)
        .toJsonForSignup();
    try {
      Response response = await dio.post('/auth/signup', data: data);

      debugPrint("response$response");

      return jsonDecode(response.toString());
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
