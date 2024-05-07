import 'package:dio/dio.dart';
import 'package:minly_media_mobile/data/services/user_shared.service.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    UserShared userShared = UserShared();
    String? token = await userShared.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
