import 'package:accu_trips/common/view_utils/root_layout.dart';
import 'package:accu_trips/common/widgets/custom_card.dart';
import 'package:accu_trips/core/text_utils/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RootLayout(
      headerTitle: 'Settings',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveValue(mobile: 5.0, tablet: 8.0, desktop: 8.0),
                  vertical: context.responsiveValue(mobile: 5.0, tablet: 8.0, desktop: 8.0),
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.responsiveValue(mobile: 2, tablet: 3, desktop: 4),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.7, // adjust based on your card design
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return CustomCard(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.accusoft, size: 50),
                            SizedBox(height: 20),
                            Text("data", style: context.typographyBold18()),
                          ],
                        ),
                      );
                    },
                    childCount: 12, // change as needed
                  ),
                ),
              ),
            ],
          );
          ;
        },
      ),
    );
  }
}
