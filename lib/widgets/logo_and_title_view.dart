//logo and title view
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/images.dart';

class LogoAndTitleView extends StatelessWidget {
  final String title;
  final String label;
  const LogoAndTitleView({
    super.key,
    required this.title,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //logo
        Image.asset(
          kLogoImage,
          height: kLogoHeight,
          width: kLogoWidth,
          fit: BoxFit.cover,
        ),
        //spacer
        const SizedBox(
          height: kMargin80,
        ),
        //title
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: kLoginTitleText),
        ),
        const SizedBox(
          height: kMarginMedium,
        ),
        //label
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: kTextRegular,
              color: kNowPlayingAndComingSoonSelectedTextColor),
        ),
      ],
    );
  }
}
