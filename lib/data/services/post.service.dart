import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:minly_media_mobile/constants/strings.dart';

class PostService {
  late Dio dio;

  // initialize the post service
  PostService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseAPIUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30), // 30 seconds
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
  }

  // get posts
  Future<Map<String, dynamic>> getPosts(int pageNumber, int pageSize) async {
    try {
      Response response =
          await dio.get('/post?pageNumber=$pageNumber&pageSize=$pageSize');

      debugPrint("response$response");

      return jsonDecode(response.toString());
    } catch (e) {
      debugPrint(e.toString());
      return {};
    }
  }
}
