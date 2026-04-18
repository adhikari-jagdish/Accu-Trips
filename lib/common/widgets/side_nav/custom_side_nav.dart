import 'package:accu_trips/app/constants/asset_paths.dart';
import 'package:accu_trips/common/widgets/side_nav/custom_navigation_rail.dart';
import 'package:accu_trips/common/widgets/side_nav/side_nav_controller.dart';
import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomSideNav extends StatelessWidget {
  final SideNavController controller = Get.find<SideNavController>();

  CustomSideNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isExpanded = controller.isExpanded.value;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: isExpanded ? 200 : 72,
        child: CustomNavigationRail(
          selectedIndex: controller.selectedIndex.value,
          isExpanded: isExpanded,
          backgroundColor: AppColors.colorPrimaryDark,
          iconSize: 20,
          labelFontSize: 13,
          itemBorderRadius: 10,
          itemPadding: 10,
          itemVerticalPadding: 8,
          horizontalPadding: 6,
          verticalItemSpacing: 3,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(6, 15, 6, 5),
            child: AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: controller.toggleRail,
                    // borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: isExpanded ? SvgPicture.asset(AssetsPaths.iconHamburgerClose, width: 18, height: 18) : SvgPicture.asset(AssetsPaths.iconHamburgerOpen, width: 18, height: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
          items: controller.menuItems.map((item) => NavigationRailItem(iconPath: item.iconPath, title: item.title, route: item.route)).toList(),
          onItemSelected: (index) => controller.onItemTapped(context, index),
        ),
      );
    });
  }
}
