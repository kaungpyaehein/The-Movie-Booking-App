import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/pages/login_page.dart';
import 'package:the_movie_booking_app/pages/main_page.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';

import '../utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _delayedNavigation();
    super.initState();
  }

  void _delayedNavigation() {
    MovieBookingModel model = MovieBookingModel();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      /// GET Cities and Navigate
      model.getCities().then((value) {
        // print(value[0].name.toString());
        /// Navigate to Login if no Bearer Token
        print(model.getBearerToken());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => model.getBearerToken().isEmpty
                  ? const LoginPage()
                  : const MainPage(),
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSplashPageBackgroundColor,
      body: Center(
        child: Image.asset(
          kSplashLogoImage,
          width: kSplashLogoWidth,
          height: kSplashLogoHeight,
        ),
      ),
    );
  }
}
