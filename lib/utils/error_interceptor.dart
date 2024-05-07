import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:minly_media_mobile/business-logic/bloc/auth/user_bloc.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;

    debugPrint(
        "Responce: errrrrrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrr");

    // final userBloc = UserBloc();

    // if (response.statusCode == 401) {
    //   userBloc.add(UserLogoutEvent());
    // }

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

  @override
  void onError(DioException err, dynamic handler) {
    final status = err.response?.statusCode;
    final isValid = status != null && status >= 200 && status < 300;

    debugPrint("err : ${err.response.toString()}");
    debugPrint("status : $status");
    debugPrint("Error:errrrrrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    final userBloc = UserBloc();
    if (err.response?.statusCode == 401) {
      userBloc.add(UserLogoutEvent());
    }

    DioException? newError = err;
    if (!isValid) {
      debugPrint('Error: ${err.error}');
      debugPrint('Error: error.error ${err.response?.data['error']['error']}');
      // debugPrint('Error: error.error.message ${response.error?.error?.message}');
      debugPrint(
          'Error:response.error.message ${err.response?.data['message']}');
      // throw DioException.badResponse(
      //   statusCode: status!,
      //   requestOptions: response.requestOptions,
      //   response: response,
      // );

      newError = DioException(
          requestOptions: err.requestOptions,
          response: Response(requestOptions: err.requestOptions, data: {
            'message': err.response?.data['error']?['message'] ??
                err.response?.data['message'] ??
                err.response?.data['error']?['status'] ??
                "Something went wrong",
            'errors': err.response?.data['error']?['error'] ?? []
          }));
    }

    handler.next(newError);
  }
}
