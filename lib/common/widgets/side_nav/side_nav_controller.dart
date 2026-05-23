import 'package:accu_trips/app/constants/asset_paths.dart';
import 'package:accu_trips/common/widgets/custom_alert_dialog.dart';
import 'package:accu_trips/common/widgets/side_nav/side_nav_model.dart';
import 'package:accu_trips/core/enum/side_nav_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SideNavController extends GetxController {
  // Observable for selected menu item
  final selectedIndex = 0.obs;

  // Observable for sidebar state based on screen size
  final sidebarState = SideNavState.expanded.obs;

  final RxBool isExpanded = false.obs;

  void toggleRail() {
    isExpanded.toggle();
  }

  void openRail() {
    isExpanded.value = true;
  }

  void closeRail() {
    isExpanded.value = false;
  }

  final List<SideNavModel> menuItems = [
    SideNavModel(iconPath: AssetsPaths.iconDashboard, title: 'Dashboard', route: '/dashboard'),
    SideNavModel(iconPath: AssetsPaths.iconQueries, title: 'Queries', route: '/queries'),
    SideNavModel(iconPath: AssetsPaths.iconAccounts, title: 'Accounts', route: '/accounts'),
    SideNavModel(iconPath: AssetsPaths.iconTour, title: 'Hotels', route: '/hotels'),
    SideNavModel(iconPath: AssetsPaths.iconSetting, title: 'Setting', route: '/settings'),
    SideNavModel(iconPath: AssetsPaths.iconLogout, title: 'Logout', action: SideNavAction.logout),
  ];

  void onItemTapped(BuildContext context, int index) {
    final item = menuItems[index];

    if (item.action == SideNavAction.logout) {
      CustomAlertDialog(title: 'Logout', content: Text('Are you sure you want to logout?'));
      return;
    }

    // Only update selection for navigable items
    selectedIndex.value = index;

    if (sidebarState.value == SideNavState.drawer) Get.back();

    if (item.route.isNotEmpty) context.go(item.route);
  }
}
