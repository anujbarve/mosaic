import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosaic_communities/constants/svg_constants.dart';
import 'package:mosaic_communities/theme/palette.dart';

class UIConstants {
  static AppBar appbar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    Text("Feed Screen"),
    Text("Search Screen"),
    Text("Notifications Screen"),
  ];
}
