import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/constants/strings.dart';
import 'package:minly_media_mobile/utils/error_interceptor.dart';
import 'package:minly_media_mobile/utils/token_interceptor.dart';

class PostService {
  late Dio dio;

  // initialize the post service
  PostService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseAPIUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
    );

    dio = Dio(options);

    dio.interceptors.addAll([
      ErrorInterceptor(),
      TokenInterceptor(),
    ]);
  }

  // get posts
  Future<Map<String, dynamic>?> getPosts(int pageNumber, int pageSize) async {
    try {
      Response response =
          await dio.get('/post?pageNumber=$pageNumber&pageSize=$pageSize');

      debugPrint("response$response");

      return jsonDecode(response.toString());
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Create Post

  Future<Map<String, dynamic>?> createPost(dynamic postFormData) async {
    try {
      Response response = await dio.post('/post', data: postFormData);
      debugPrint("response$response");
      return jsonDecode(response.toString());
    } catch (e) {
      debugPrint("service-Error $e");
      return null;
    }
  }
}
