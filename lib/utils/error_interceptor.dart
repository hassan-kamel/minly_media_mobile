import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;

    Response newResponse = response;
    if (!isValid) {
      debugPrint('Error: ${response.data}');
      debugPrint('Error: data.error ${response.data['error']}');
      // debugPrint('Error: data.error.message ${response.data?.error?.message}');
      debugPrint('Error:response.data.message ${response.data['message']}');
      // throw DioException.badResponse(
      //   statusCode: status!,
      //   requestOptions: response.requestOptions,
      //   response: response,
      // );

      newResponse = Response(requestOptions: response.requestOptions, data: {
        'message': response.data['error']?['message'] ??
            response.data['message'] ??
            response.data['error']?['status'] ??
            "Something went wrong",
        'errors': response.data['error']?['error'] ?? []
      });
    }
    super.onResponse(newResponse, handler);
  }
}
