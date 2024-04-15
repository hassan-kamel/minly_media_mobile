import 'package:dio/dio.dart';
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
  Future<List<Map<String, dynamic>>> getPosts(
      int pageNumber, int pageSize) async {
    try {
      Response response =
          await dio.get('/posts?pageNumber=$pageNumber&pageSize=$pageSize');

      print("response" + response.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
