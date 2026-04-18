import 'package:accu_trips/common/controller/text_field_state_controller.dart';
import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onSuffixPressed;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.onSuffixPressed,
    this.maxLines = 1,
    this.maxLength = 100,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffix,
    this.inputFormatters,
    this.onChanged,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    // Create per-instance controller if not provided
    final ctrl = Get.put(
      TextFieldStateController(),
      tag: key?.toString() ?? hashCode.toString(), // unique per widget instance
    );

    final internalController = controller ?? TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.typographyBold18()),
          const SizedBox(height: 6),

          // Reactive part: border + field + error text
          Obx(() {
            final hasError = ctrl.hasError.value;

            return TextFormField(
              controller: internalController,
              maxLines: maxLines,
              maxLength: maxLength,
              keyboardType: keyboardType,
              readOnly: onSuffixPressed != null,
              textCapitalization: TextCapitalization.words,
              inputFormatters: inputFormatters,
              validator: (value) {
                final validationResult = validator?.call(value);
                ctrl.setError(validationResult); // ← update GetX state
                return validationResult; // still return it so Form knows it's invalid
              },

              decoration: InputDecoration(
                hintText: hintText,
                counterText: "",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                suffixIcon: suffix,
                errorText: hasError ? ' ' : null,

                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: fillColor ?? Colors.white,
              ),
              onChanged: onChanged,
            );
          }),
        ],
      ),
    );
  }
}
