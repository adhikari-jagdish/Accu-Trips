import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_clock/one_clock.dart';

class SubHeader extends StatefulWidget {
  final bool isMobile;

  const SubHeader({super.key, this.isMobile = false});

  @override
  State<SubHeader> createState() => _OntaTripSubHeaderState();
}

class _OntaTripSubHeaderState extends State<SubHeader> {
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMobile) return const SizedBox.shrink();

    final double titleFontSize = context.responsiveValue(desktop: 20.0, tablet: 17.0, mobile: 14.0);

    final double subtitleFontSize = context.responsiveValue(desktop: 12.0, tablet: 11.0, mobile: 10.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.responsiveValue(desktop: 32.0, tablet: 16.0, mobile: 10.0), vertical: 14),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.colorPrimaryDark, AppColors.colorPrimary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: AppColors.colorPrimaryDark.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // ── Left: Title, Date & Digital Clock ──────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Dashboard Overview',
                style: TextStyle(color: Colors.white, fontSize: titleFontSize, fontWeight: FontWeight.bold, letterSpacing: 0.4),
              ),
              const SizedBox(height: 4),
              // Live date
              Text(
                DateFormat('EEEE, MMMM dd, yyyy').format(_currentTime),
                style: TextStyle(color: Colors.white70, fontSize: subtitleFontSize, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              // Sub-tagline
              Text(
                'Real-time insights into your travel management system',
                style: TextStyle(color: Colors.white38, fontSize: subtitleFontSize - 1),
              ),
              const SizedBox(height: 12),
            ],
          ),
          const SizedBox(width: 10),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveValue(desktop: 16.0, tablet: 12.0, mobile: 10.0),
              vertical: context.responsiveValue(desktop: 7.0, tablet: 6.0, mobile: 5.0),
            ),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.colorPrimary.withValues(alpha: 0.5), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time_rounded, color: AppColors.colorPrimary, size: context.responsiveValue(desktop: 15.0, tablet: 13.0, mobile: 11.0)),
                const SizedBox(width: 6),
                DigitalClock(
                  showSeconds: true,
                  isLive: true,
                  digitalClockTextColor: AppColors.colorPrimary,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  datetime: _currentTime,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
