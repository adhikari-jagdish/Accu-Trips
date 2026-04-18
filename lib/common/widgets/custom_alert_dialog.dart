import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Future<bool> showDeleteAlertDialog(
  BuildContext context, {
  String actionTitle = 'Delete Record',
  String actionLabel = 'Delete',
  String? confirmText,
  Color actionColor = const Color(0xFFDC2626),
  Color disabledActionColor = const Color(0xFFFCA5A5),
  Color iconBgColor = const Color(0xFFFEE2E2),
  IconData iconData = Icons.delete_outline_rounded,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => CustomAlertDialog(title: actionTitle, subtitle: actionLabel, content: Text(confirmText ?? 'Are you sure you want to delete this record?')),
  );
  return result ?? false;
}

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final Color titleColor;
  final String? subtitle;
  final Color subtitleColor;

  final Widget? content;
  final Widget? footer;
  final List<Widget>? actions;

  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? footerPadding;

  final Color backgroundColor;
  final Color? headerColor;

  final double? maxWidth;
  final double? maxHeight;

  final bool showCloseIcon;
  final bool isLoading;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.titleColor = Colors.white,
    this.subtitle,
    this.subtitleColor = Colors.white,
    this.content,
    this.footer,
    this.actions,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.all(20),
    this.headerPadding,
    this.contentPadding,
    this.footerPadding,
    this.backgroundColor = Colors.white,
    this.headerColor,
    this.maxWidth = 650,
    this.maxHeight,
    this.showCloseIcon = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: backgroundColor,
      insetPadding: EdgeInsets.all(size.width < 600 ? 12 : 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 650, maxHeight: maxHeight ?? size.height * 0.95),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null || subtitle != null)
                  Container(
                    width: double.infinity,
                    padding: headerPadding ?? const EdgeInsets.fromLTRB(20, 16, 12, 16),
                    decoration: BoxDecoration(
                      color: headerColor ?? AppColors.colorPrimary.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null) Text(title!, style: context.typographyBold18().copyWith(color: titleColor)),
                              if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: context.typographyRegular14().copyWith(color: subtitleColor))],
                            ],
                          ),
                        ),

                        if (showCloseIcon) IconButton(icon: const Icon(Icons.close), color: Colors.white, onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ),

                Flexible(
                  child: SingleChildScrollView(
                    padding: contentPadding ?? padding,
                    child: Align(alignment: Alignment.topLeft, child: content ?? const SizedBox.shrink()),
                  ),
                ),

                if (actions != null || footer != null)
                  Padding(
                    padding: footerPadding ?? const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: footer ?? Row(mainAxisAlignment: MainAxisAlignment.end, children: actions!),
                  ),
              ],
            ),

            if (isLoading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(borderRadius)),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
