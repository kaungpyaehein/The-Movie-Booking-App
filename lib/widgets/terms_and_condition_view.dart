import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../utils/strings.dart';

class TermsAndConditionView extends StatelessWidget {
  const TermsAndConditionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      kTermsAndConditionsLabel,
      style: TextStyle(
          color: kNowPlayingAndComingSoonSelectedTextColor,
          fontSize: kTextSmall),
    );
  }
}