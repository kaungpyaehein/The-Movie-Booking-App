import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:the_movie_booking_app/pages/login_page.dart';
import 'package:the_movie_booking_app/pages/pick_region_page.dart';
import 'package:the_movie_booking_app/utils/strings.dart';
import 'package:the_movie_booking_app/widgets/logo_and_title_view.dart';
import 'package:the_movie_booking_app/widgets/terms_and_condition_view.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Center(
              child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    //Spacer
                    const SizedBox(
                      height: kMarginXLarge,
                    ),
                    //Login and title view
                    const LogoAndTitleView(
                      title: kOTPTitle,
                      label: kOTPTLabel,
                    ),
                    const SizedBox(
                      height: kMargin60,
                    ),
                    //OTP input view
                    const OTPInputView(),

                    //Spacer
                    const SizedBox(
                      height: kMarginXLarge2,
                    ),
                    //Resend code view
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: kDontReceiveOTPLabel,
                          style: TextStyle(
                              color: Colors.white, fontSize: kTextRegular)),
                      TextSpan(
                          text: kResendCodeLabel,
                          style: TextStyle(
                              color: kPrimaryColor, fontSize: kTextRegular2X)),
                    ])),

                    //Spacer
                    const SizedBox(
                      height: kMarginXLarge2,
                    ),

                    PrimaryButtonView(
                      title: kConfirmOTPLabel,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context) => const PickRegionPage(),));
                      },
                    ),

                    //Spacer
                    const SizedBox(
                      height: kMovieDetailsSmallImageWidth,
                    ),

                    //Terms and conditions view

                  ],
                ),
              ),

              //Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: kMarginXLarge2,
                      color: kNowPlayingAndComingSoonSelectedTextColor,
                    )),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child:   Padding(
                  padding: EdgeInsets.only(bottom: kMargin30),
                  child: TermsAndConditionView(),
                ),
              )
            ],
          ))),
    );
  }
}

class OTPInputView extends StatelessWidget {
  const OTPInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMargin35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            kEnterOTPLabel,
            style: TextStyle(color: kEnterOTPColor),
          ),
          const SizedBox(
            height: kMarginMedium,
          ),
          Pinput(
            defaultPinTheme: pinTheme,
            focusedPinTheme: pinTheme,
            submittedPinTheme: pinTheme,
            enabled: true,
            length: 6,
          ),
        ],
      ),
    );
  }
}

final pinTheme = PinTheme(
  width: kCountryCodeDropDownHeight,
  height: kCountryCodeDropDownHeight,
  textStyle: const TextStyle(
      fontSize: kTextRegular,
      color: kOTPPinTextColor,
      fontWeight: FontWeight.w500),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4),
  ),
);
