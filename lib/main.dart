import 'package:flutter/material.dart';

import 'package:the_movie_booking_app/pages/splash_page.dart';

import 'package:the_movie_booking_app/utils/fonts.dart';

void main() {
  runApp(const MovieBookingApp());
}

class MovieBookingApp extends StatelessWidget {
  const MovieBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: kInter),
      home: const SplashPage(),
    );
  }
}
