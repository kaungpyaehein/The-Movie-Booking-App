import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

import 'package:the_movie_booking_app/pages/login_page.dart';
import 'package:the_movie_booking_app/pages/pick_region_page.dart';
import 'package:the_movie_booking_app/utils/strings.dart';
import 'package:the_movie_booking_app/widgets/logo_and_title_view.dart';
import 'package:the_movie_booking_app/widgets/terms_and_condition_view.dart';

import '../data/models/movie_booking_model.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  const OTPPage({super.key, required this.phoneNumber});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController pinController = TextEditingController();
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
                OTPInputView(
                  pinController: pinController,
                ),

                //Spacer
                const SizedBox(
                  height: kMarginXLarge2,
                ),

                //Resend code view
                const ResendCodeView(),

                //Spacer
                const SizedBox(
                  height: kMarginXLarge2,
                ),

                PrimaryButtonView(
                  title: kConfirmOTPLabel,
                  onTap: () {
                    loginWithPhone(context);
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
            child: Padding(
              padding: EdgeInsets.only(bottom: kMargin30),
              child: TermsAndConditionView(),
            ),
          )
        ],
      ))),
    );
  }

  void loginWithPhone(BuildContext context) {
    debugPrint(pinController.text.toString());
    MovieBookingModel model = MovieBookingModel();

    /// Call Get OTP
    model
        .signInWithPhone(
            widget.phoneNumber, pinController.text.trim().toString())
        .then((response) {
      if (response.token.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PickRegionPage(),
            ));
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed to login, please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Failed to login, please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}

class ResendCodeView extends StatelessWidget {
  const ResendCodeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: kDontReceiveOTPLabel,
          style: TextStyle(color: Colors.white, fontSize: kTextRegular)),
      TextSpan(
          text: kResendCodeLabel,
          style: TextStyle(color: kPrimaryColor, fontSize: kTextRegular2X)),
    ]));
  }
}

class OTPInputView extends StatelessWidget {
  final TextEditingController pinController;
  const OTPInputView({super.key, required this.pinController});

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
            controller: pinController,
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

//pin theme
final pinTheme = PinTheme(
  width: kMargin50,
  height: kMargin50,
  textStyle: const TextStyle(
      fontSize: kTextRegular,
      color: kOTPPinTextColor,
      fontWeight: FontWeight.w500),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4),
  ),
);
