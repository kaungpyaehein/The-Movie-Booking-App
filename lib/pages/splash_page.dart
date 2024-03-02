import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/pages/login_page.dart';
import 'package:the_movie_booking_app/pages/pick_region_page.dart';
import 'package:the_movie_booking_app/utils/dimensions.dart';
import 'package:the_movie_booking_app/utils/images.dart';

import '../utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  MovieBookingModel model = MovieBookingModel();
  @override
  void initState() {
    model.getCities();
    _delayedNavigation();
    super.initState();
  }

  void _delayedNavigation() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
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
