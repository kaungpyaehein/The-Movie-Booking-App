import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/country_code_list.dart';
import 'package:the_movie_booking_app/pages/otp_page.dart';
import 'package:the_movie_booking_app/utils/colors.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';
import 'package:the_movie_booking_app/utils/strings.dart';

import '../widgets/logo_and_title_view.dart';
import '../widgets/terms_and_condition_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                const CountryCodeAndPhoneNumberInputView(),

                //spacer
                const SizedBox(
                  height: kMargin50,
                ),

                //verify phone number button
                PrimaryButtonView(
                  title: kVerifyPhoneNumberLabel,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OTPPage(),
                        ));
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
                const SizedBox(height: kMarginXXLarge2,),
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
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginXLarge),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize:
                const Size(double.infinity, kMargin50),
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
            minimumSize:
                const Size(double.infinity, kMargin50),
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
  const CountryCodeAndPhoneNumberInputView({
    super.key,
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
          const Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
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
