enum SideNavAction { route, logout, none }

class SideNavModel {
  final String iconPath;
  final String title;
  final String route;
  final SideNavAction action;

  SideNavModel({
    required this.iconPath,
    required this.title,
    this.route = '',
    this.action = SideNavAction.route,
  });
}
