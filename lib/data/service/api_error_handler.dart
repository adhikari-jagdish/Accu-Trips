import 'package:dio/dio.dart';

/// Represents a parsed API error with field-level details.
class ApiErrorResult {
  final String message;
  final String? code;
  final Map<String, String> fieldErrors;

  const ApiErrorResult({required this.message, this.code, this.fieldErrors = const {}});

  bool get hasFieldErrors => fieldErrors.isNotEmpty;
}

ApiErrorResult? parseApiError(DioException e) {
  final response = e.response;
  if (response == null) {
    return ApiErrorResult(message: e.message ?? 'Network error');
  }

  final data = response.data;
  if (data is! Map<String, dynamic>) {
    return ApiErrorResult(message: 'HTTP ${response.statusCode}');
  }

  // Check for 'error' key
  if (data.containsKey('error')) {
    final error = data['error'];
    if (error is Map<String, dynamic>) {
      final code = error['code'] as String?;
      final details = error['details'];
      String mainMessage = '';
      final fieldErrors = <String, String>{};

      if (details is List) {
        for (final detail in details) {
          if (detail is Map<String, dynamic>) {
            final msg = detail['message'] as String? ?? '';
            final field = detail['field'] as String?;
            if (mainMessage.isEmpty) mainMessage = msg;
            if (field != null && field.isNotEmpty) {
              fieldErrors[field] = msg;
            }
          }
        }
      }

      if (mainMessage.isEmpty) {
        mainMessage = error['message'] as String? ?? data['message'] as String? ?? 'An error occurred';
      }

      return ApiErrorResult(message: mainMessage, code: code, fieldErrors: fieldErrors);
    }
  }

  // Fallback to top-level message
  final message = data['message'] as String? ?? 'HTTP ${response.statusCode}';
  return ApiErrorResult(message: message);
}
