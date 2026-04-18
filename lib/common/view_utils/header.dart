import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, required this.headerTitle});

  final String? headerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.responsiveValue(mobile: 0.0, tablet: 0.0, desktop: 10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: context.responsiveValue(mobile: Radius.circular(0), tablet: Radius.circular(0), desktop: Radius.circular(15)),
          bottomRight: context.responsiveValue(mobile: Radius.circular(0), tablet: Radius.circular(0), desktop: Radius.circular(0)),
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: context.responsiveValue(mobile: kToolbarHeight, tablet: kToolbarHeight, desktop: 0),
          backgroundColor: AppColors.colorPrimaryDark,
          title: context.responsiveValue(
            mobile: SizedBox.shrink(),
            desktop: Text('Welcome Back', style: context.typographyBold18().copyWith(color: Colors.white)),
            tablet: Text('Welcome Back', style: context.typographyBold18().copyWith(color: Colors.white)),
          ),
          leading: context.responsiveValue(
            mobile: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            tablet: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            desktop: SizedBox.shrink(),
          ),

          actions: [
            // Search Bar — responsive width per breakpoint
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: context.responsiveValue(mobile: 160.0, tablet: 240.0, desktop: 340.0),
                child: Container(
                  height: context.responsiveValue(mobile: 36.0, tablet: 40.0, desktop: 42.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: TextField(
                    cursorColor: Colors.amber,
                    cursorWidth: 2.0,
                    cursorHeight: 20,
                    style: context.typographyLight18().copyWith(color: Colors.white, fontSize: context.responsiveValue(mobile: 12.0, tablet: 13.0, desktop: 14.0)),
                    decoration: InputDecoration(
                      hintText: context.responsiveValue(mobile: 'Search...', tablet: 'Search Trips...', desktop: 'Search Trips or Bookings...'),
                      hintStyle: context.typographyLight18().copyWith(color: Colors.white60, fontSize: context.responsiveValue(mobile: 12.0, tablet: 13.0, desktop: 14.0)),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.responsiveValue(mobile: 14.0, tablet: 16.0, desktop: 20.0),
                        vertical: context.responsiveValue(mobile: 0.0, tablet: 3.0, desktop: 4.0),
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search_rounded, color: Colors.white70, size: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0)),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: IconButton(
                icon: Icon(Icons.add),
                color: AppColors.colorPrimary,
                padding: EdgeInsets.zero, // remove padding
                constraints: const BoxConstraints(), // remove default constraints
                iconSize: 28,
                onPressed: () => {},
              ),
            ),

            const SizedBox(width: 12),

            // Notification Icon
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_none_outlined, color: Colors.white, size: 28),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: const Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
