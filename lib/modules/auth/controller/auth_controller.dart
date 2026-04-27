import 'package:accu_trips/core/secure_storage.dart';
import 'package:accu_trips/data/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService authService;
  final SecureStorage _secure = SecureStorage();

  AuthController({required this.authService});

  Future<void> clearSession() async {
    await _secure.deleteSecureData('accessToken');
    await _secure.deleteSecureData('access_token');
    await _secure.deleteSecureData('refreshToken');
    await _secure.deleteSecureData('expiresAt');
  }

  Future<DioException?> checkAValidateAndRefreshAuth() async {}
}
