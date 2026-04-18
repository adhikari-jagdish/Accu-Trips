import 'package:accu_trips/common/view_utils/root_layout.dart';
import 'package:accu_trips/common/view_utils/sub_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return RootLayout(
      headerTitle: 'Dashboard',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveValue(mobile: 5.0, tablet: 10.0, desktop: 10.0),
                  vertical: context.responsiveValue(mobile: 5.0, tablet: 10.0, desktop: 10.0),
                ),
                sliver: SliverList(delegate: SliverChildListDelegate([const SubHeader(), const SizedBox(height: 8)])),
              ),
            ],
          );
        },
      ),
    );
  }
}
