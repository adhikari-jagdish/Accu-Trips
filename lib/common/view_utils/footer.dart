import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  final List<IconData> socialIcons = [FontAwesomeIcons.facebook, FontAwesomeIcons.twitter, FontAwesomeIcons.pinterest, FontAwesomeIcons.linkedin];

  final List<String> socialIconsUrl = ['https://www.facebook.com/ontatrip', 'https://www.twitter.com/ontatrip', 'https://www.pinterest.com/ontatrip', 'https://www.linkedin.com/ontatrip'];

  final int numberOfSocialIcons = 4;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 36,
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: AppColors.accentText,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("© ${DateFormat.y().format(DateTime.now())}, Aspiration Asia Pvt Ltd", style: const TextStyle(color: Colors.white, fontSize: 12)),
          ListView(scrollDirection: Axis.horizontal, shrinkWrap: true, children: getAllSocialIcons()),
        ],
      ),
    );
  }

  ///This function returns list of Social Icons Widget
  List<Widget> getAllSocialIcons() {
    return List.generate(
      numberOfSocialIcons,
      (index) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () => _launchUrl(socialIconsUrl[index]),
          child: Icon(socialIcons[index], color: Colors.white, size: 15),
        ),
      ),
    );
  }

  ///Url Launching
  Future<void> _launchUrl(String url) async {
    final socialUri = Uri.parse(url);
    if (await canLaunchUrl(socialUri)) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch url');
    }
  }
}
