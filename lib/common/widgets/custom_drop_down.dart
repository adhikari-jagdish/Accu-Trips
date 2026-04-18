import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;
  final String? hint;
  final String title;
  final Color? fillColor;

  const CustomDropDown({super.key, required this.value, required this.items, required this.labelBuilder, required this.onChanged, this.hint, required this.title, this.fillColor});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = items.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.typographyBold18()),
          const SizedBox(height: 4),
          DropdownButtonFormField<T>(
            initialValue: isEmpty ? null : value,
            isExpanded: true,
            hint: Text(
              isEmpty ? "No $title available" : (hint ?? "Select $title"),
              style: TextStyle(color: isEmpty ? Colors.grey.shade600 : null, fontStyle: isEmpty ? FontStyle.italic : null),
            ),
            items: isEmpty
                ? null // ← no items = safe & clean
                : items.map((item) {
                    return DropdownMenuItem<T>(
                      value: item,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            child: Text(labelBuilder(item), overflow: TextOverflow.ellipsis, maxLines: 1),
                          );
                        },
                      ),
                    );
                  }).toList(),
            onChanged: isEmpty ? null : onChanged, // ← disable interaction
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: isEmpty ? Colors.grey.shade400 : Colors.grey.shade300),
              ),
              filled: true,
              fillColor: fillColor ?? Colors.white,
            ),
            menuMaxHeight: 300,
            icon: const Icon(Icons.arrow_drop_down),
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }
}
