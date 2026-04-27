import 'dart:io';

import 'package:accu_trips/app/routes/app_routes.dart';
import 'package:accu_trips/data/service/api_utils.dart';
import 'package:accu_trips/modules/auth/controller/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as my_get;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as flutter_secure;

class DioService {
  static const _storage = flutter_secure.FlutterSecureStorage();

  final Dio dio = Dio(BaseOptions(baseUrl: ApiUtils.apiUrl))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Validate and refresh the token before every API call
          try {
            final authCtrl = my_get.Get.find<AuthController>();
            final dExcep = await authCtrl.checkAValidateAndRefreshAuth();
            if (dExcep != null) {
              return handler.reject(dExcep);
            }
          } catch (_) {
            // AuthController not registered yet (e.g. during startup) — proceed without check
          }

          // Re-read token after validation (it may have been refreshed)
          String? accessToken = await _storage.read(key: 'accessToken');
          accessToken ??= await _storage.read(key: 'access_token');

          options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
          options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
          options.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
          options.headers[HttpHeaders.acceptHeader] = '*/*';
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (error, handler) async {
          // On 401, attempt a single token refresh and retry
          if (error.response?.statusCode == 401 && error.requestOptions.extra['_retried'] != true) {
            try {
              final authCtrl = my_get.Get.find<AuthController>();
              final refreshError = await authCtrl.checkAValidateAndRefreshAuth();
              if (refreshError == null) {
                // Token refreshed successfully — retry the original request
                String? newToken = await _storage.read(key: 'accessToken');
                newToken ??= await _storage.read(key: 'access_token');

                final opts = error.requestOptions;
                opts.headers[HttpHeaders.authorizationHeader] = 'Bearer $newToken';

                final response = await Dio(BaseOptions(baseUrl: ApiUtils.apiUrl)).fetch(opts);
                return handler.resolve(response);
              } else {
                // Refresh failed — clear session and navigate to login
                await authCtrl.clearSession();
                router.go('/login');
              }
            } catch (_) {
              // Refresh attempt itself failed
            }
          }
          return handler.next(error);
        },
      ),
    );
}
