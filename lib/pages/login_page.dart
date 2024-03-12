import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/sample_vos/country_code_list.dart';
import 'package:the_movie_booking_app/pages/otp_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../widgets/logo_and_title_view.dart';
import '../widgets/terms_and_condition_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //spacer
                const SizedBox(
                  height: kMarginXLarge,
                ),

                //logo and title view
                const LogoAndTitleView(
                  title: kLoginTitle,
                  label: kLoginLabel,
                ),
                //spacer
                const SizedBox(
                  height: kMargin80,
                ),

                //country code and mobile input field
                CountryCodeAndPhoneNumberInputView(
                  phoneNumberController: phoneNumberController,
                ),

                //spacer
                const SizedBox(
                  height: kMargin50,
                ),

                //verify phone number button
                PrimaryButtonView(
                  title: kVerifyPhoneNumberLabel,
                  onTap: () {
                    getOTP(context);
                  },
                ),
                const SizedBox(
                  height: kMargin30,
                ),
                //divider
                const DividerView(),
                const SizedBox(
                  height: kMargin30,
                ),
                //google sign in button
                const GoogleSignInButton(),
                const SizedBox(
                  height: kMarginXXLarge2,
                ),
                //Terms and conditions text view
                const Padding(
                  padding: EdgeInsets.only(bottom: kMargin30),
                  child: TermsAndConditionView(),
                )
                // spacer
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getOTP(BuildContext context) {
    debugPrint(phoneNumberController.text.toString());
    MovieBookingModel model = MovieBookingModel();
    if (phoneNumberController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Phone number is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      /// Call Get OTP
      model
          .getOtpResponse(phoneNumberController.text.trim().toString())
          .then((response) {
        if (response.code == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPPage(
                  phoneNumber: phoneNumberController.text.trim().toString(),
                ),
              ));
          Fluttertoast.showToast(
              msg: "OTP has been sent successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Failed to request OTP, please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginXLarge),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, kMargin50),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kMarginMedium))),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kGoogleLogo,
              height: kMarginLarge,
              width: kMarginLarge,
            ),
            const SizedBox(
              width: kMarginMedium2,
            ),
            const Text(
              kGoogleSignInLabel,
              style: TextStyle(
                color: Colors.black,
                fontSize: kTextRegular2X,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DividerView extends StatelessWidget {
  const DividerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginXLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 1,
              endIndent: kMarginMedium4,
            ),
          ),
          Text(
            kOrText,
            style: TextStyle(
              color: Colors.white,
              fontSize: kTextRegular2X,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 1,
              indent: kMarginMedium4,
            ),
          ),
        ],
      ),
    );
  }
}

//primary button
class PrimaryButtonView extends StatelessWidget {
  const PrimaryButtonView({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginXLarge),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, kMargin50),
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kMarginMedium))),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: kTextRegular2X,
          ),
        ),
      ),
    );
  }
}

//country code and number input
class CountryCodeAndPhoneNumberInputView extends StatefulWidget {
  final TextEditingController phoneNumberController;
  const CountryCodeAndPhoneNumberInputView({
    super.key,
    required this.phoneNumberController,
  });

  @override
  State<CountryCodeAndPhoneNumberInputView> createState() =>
      _CountryCodeAndPhoneNumberInputViewState();
}

class _CountryCodeAndPhoneNumberInputViewState
    extends State<CountryCodeAndPhoneNumberInputView> {
  String selectedItem = countryCodeList[0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginXLarge),
      child: Row(
        children: [
          //country code
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                kCountryCodeLabel,
                style: TextStyle(
                  color: kNowPlayingAndComingSoonSelectedTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: kTextSmall,
                ),
              ),
              DropdownButton(
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  width: kCountryCodeDropDownWidth,
                  color: Colors.white,
                  height: 1,
                ),
                itemHeight: kMargin50,
                iconEnabledColor: kNowPlayingAndComingSoonSelectedTextColor,
                dropdownColor: Colors.black,
                value: selectedItem,
                icon: const Padding(
                  padding: EdgeInsets.only(bottom: kMarginMedium2),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: kMarginXLarge,
                  ),
                ),
                items: countryCodeList.map((item) {
                  return DropdownMenuItem(
                      value: item,
                      child: SizedBox(
                        width: kMargin60,
                        height: kMarginXLarge,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: kTextRegular2X,
                            color: Colors.white,
                          ),
                        ),
                      ));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            width: kMarginMedium4,
          ),
          //phone number field
          Expanded(
            child: TextField(
              controller: widget.phoneNumberController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 13),
                  hintText: kMobileNumberHintText,
                  hintStyle: TextStyle(
                    color: kNowPlayingAndComingSoonSelectedTextColor,
                    fontSize: kTextRegular2X,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, style: BorderStyle.solid)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, style: BorderStyle.solid))),
            ),
          )
        ],
      ),
    );
  }
}
