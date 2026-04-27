import 'dart:io';

import 'package:accu_trips/data/service/api_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as my_get;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as flutter_secure;

class AuthService {
  static Dio dio = Dio(BaseOptions(baseUrl: ApiUtils.userAuthApiUrl, responseType: ResponseType.json))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? accessToken = await const flutter_secure.FlutterSecureStorage().read(key: 'accessToken');
          accessToken ??= await const flutter_secure.FlutterSecureStorage().read(key: 'access_token');
          // validate the access token and refresh if needed before proceeding
          // final dExcep = await my_get.Get.find<AuthController>().checkAValidateAndRefreshAuth();
          // if (dExcep != null) {
          //   return handler.reject(dExcep);
          // }
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          final storage = const flutter_secure.FlutterSecureStorage();
          final body = response.data;

          print('Dio Login Response $body');

          if (body != null && body['data'] != null) {
            final token = body['data']['access_token'];

            print('The received Token $token');

            if (token != null) {
              await storage.write(key: 'access_token', value: token);
            }
          }

          return handler.next(response);
        },
        onError: (error, handler) async {
          print('Dio Login Error $error');
        },
      ),
    );

  Future<Response> login({required String identifier, required String password}) async {
    return await dio.post('/login', data: {'identifier': identifier, 'password': password});
  }

  Future<Response> resendEmailOtp({required String identifier}) async {
    return await dio.post('resend-email-otp', data: {'identifier': identifier});
  }
}
