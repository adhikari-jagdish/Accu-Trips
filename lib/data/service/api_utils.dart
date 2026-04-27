import 'package:dio/dio.dart';

class ApiUtils {
  /// Production URLs
  static const String userAuthApiUrl = "/auth";
  // static const String apiUrl = "http://38.242.135.250:8010/api/v1";
  static const String apiUrl = "http://192.168.18.1:9001/api";

  static ApiUtilsModel parseResponse(
    Response response, {
    bool expectSingle = false, // true → treat 'data' as single object
    bool includeTokens = false, // true → extract authorization header
  }) {
    final json = response.data;

    // Default values
    bool success = false;
    String message = '';
    List<Map<String, dynamic>> formattedData = [];
    String? accessToken;
    String? refreshToken;

    // 1. Determine success status
    if (json is Map<String, dynamic>) {
      // Prefer explicit "success" field if present
      if (json.containsKey('success')) {
        final rawSuccess = json['success'];
        success = rawSuccess == true || rawSuccess == 'true' || rawSuccess == 1;
      }
      // Fallback: HTTP 2xx range
      else if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        success = true;
      }

      // Extract message
      if (json['message'] != null) {
        message = json['message'] as String;
      }
    }

    // 2. Parse 'data' field
    if (json is Map<String, dynamic> && json.containsKey('data')) {
      final raw = json['data'];

      if (raw is List) {
        formattedData = raw.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
      } else if (raw is Map) {
        final single = Map<String, dynamic>.from(raw);
        formattedData = [single];
      }
      // ignore other types
    }

    // 3. Extract tokens if requested
    if (includeTokens) {
      final authHeader = response.headers.value('authorization');
      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        accessToken = authHeader.substring(7);
      }
      // refreshToken = json['refreshToken'] as String?;   // ← uncomment if used
    }

    return ApiUtilsModel(success: success, message: message, data: formattedData, accessToken: accessToken, refreshToken: refreshToken);
  }

  // Convenience wrappers
  static ApiUtilsModel getMessageAndMultiDataFromResponse(Response response) {
    return parseResponse(response, expectSingle: false);
  }

  static ApiUtilsModel getMessageAndSingleDataFromResponse(Response response) {
    return parseResponse(response, expectSingle: true);
  }

  static ApiUtilsModel getMessageTokensAndSingleDataFromResponse(Response response) {
    return parseResponse(response, expectSingle: true, includeTokens: true);
  }

  /// Centralized error helper
  static Never handleHttpException(Response response) {
    final errorMsg = (response.data is Map<String, dynamic> && response.data['message'] != null) ? response.data['message'] as String : 'HTTP ${response.statusCode} - Unknown error';

    throw Exception(errorMsg);
  }
}

class ApiUtilsModel {
  final bool success;
  final String message;
  final List<Map<String, dynamic>> data;
  final String? accessToken;
  final String? refreshToken;

  ApiUtilsModel({required this.success, required this.message, required this.data, this.accessToken, this.refreshToken});
}
