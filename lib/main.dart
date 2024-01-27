import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/network/data_agents/dio_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/http_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/pages/checkout_page.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/pages/profile_page.dart';
import 'package:the_movie_booking_app/pages/seating_plan_page.dart';
import 'package:the_movie_booking_app/pages/snack_page.dart';

import 'package:the_movie_booking_app/pages/splash_page.dart';
import 'package:the_movie_booking_app/pages/ticket_information_page.dart';

import 'package:the_movie_booking_app/utils/fonts.dart';

import 'pages/search_movie_page.dart';

void main() {
  // HttpDataAgentImpl().getNowPlayingMovie(1);
  // DioMovieDataAgentImpl().getNowPlayingMovie(1);

  //abstraction and polymorphism
  MovieBookingDataAgent dataAgent = DioMovieDataAgentImpl();
  dataAgent.getNowPlayingMovies(1);

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
