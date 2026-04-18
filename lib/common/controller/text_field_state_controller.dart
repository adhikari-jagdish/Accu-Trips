import 'package:get/get.dart';

class TextFieldStateController extends GetxController {
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  void setError(String? msg) {
    if (msg == null || msg.isEmpty) {
      hasError.value = false;
      errorMessage.value = '';
    } else {
      hasError.value = true;
      errorMessage.value = msg;
    }
  }

  void clearError() {
    hasError.value = false;
    errorMessage.value = '';
  }
}
