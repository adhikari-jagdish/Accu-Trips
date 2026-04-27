import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

/// Centralised toast/notification helper.
///
/// Usage:
///   AppToast.error('Something went wrong.');
///   AppToast.success('Saved!', title: 'Done');
///   AppToast.warning('Check your input.');
///   AppToast.info('New update available.');
///   AppToast.show('Custom message', accent: Colors.purple);
class AppToast {
  AppToast._();

  // ── Public API ────────────────────────────────────────────────────────────

  static void error(String message, {String? title}) => _show(
    title: title ?? 'Error',
    message: message,
    accent: const Color(0xFFD32F2F),
    icon: Icons.error_outline_rounded,
  );

  static void success(String message, {String? title}) => _show(
    title: title ?? 'Success',
    message: message,
    accent: const Color(0xFF2E7D32),
    icon: Icons.check_circle_outline_rounded,
  );

  static void warning(String message, {String? title}) => _show(
    title: title ?? 'Warning',
    message: message,
    accent: const Color(0xFFED6C02),
    icon: Icons.warning_amber_rounded,
  );

  static void info(String message, {String? title}) => _show(
    title: title ?? 'Info',
    message: message,
    accent: AppColors.colorPrimary,
    icon: Icons.info_outline_rounded,
  );

  static void show(
    String message, {
    String title = 'Notice',
    Color? accent,
    IconData? icon,
    Duration duration = const Duration(seconds: 4),
  }) => _show(
    title: title,
    message: message,
    accent: accent ?? AppColors.colorPrimary,
    icon: icon ?? Icons.notifications_none_rounded,
    duration: duration,
  );

  // ── Internal ──────────────────────────────────────────────────────────────

  static void _show({
    required String title,
    required String message,
    required Color accent,
    required IconData icon,
    Duration duration = const Duration(seconds: 4),
  }) {
    BotToast.showCustomNotification(
      duration: duration,
      align: const Alignment(1.0, -0.85),
      animationDuration: const Duration(milliseconds: 280),
      animationReverseDuration: const Duration(milliseconds: 200),
      onlyOne: false,
      crossPage: true,
      toastBuilder: (cancel) => _AppToastCard(
        title: title,
        message: message,
        accent: accent,
        icon: icon,
        onClose: cancel,
      ),
    );
  }
}

// ── Private card widget ────────────────────────────────────────────────────

class _AppToastCard extends StatelessWidget {
  const _AppToastCard({
    required this.title,
    required this.message,
    required this.accent,
    required this.icon,
    required this.onClose,
  });

  final String title;
  final String message;
  final Color accent;
  final IconData icon;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 12, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon badge
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: accent, size: 18),
            ),
            const SizedBox(width: 10),
            // Text column
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                      height: 1.2,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.45,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            // Close button
            GestureDetector(
              onTap: onClose,
              child: const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.close_rounded,
                  size: 15,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
