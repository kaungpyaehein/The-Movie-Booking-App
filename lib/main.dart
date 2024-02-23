import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_movie_booking_app/data/vos/collection_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:the_movie_booking_app/network/data_agents/dio_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/http_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/the_movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/pages/checkout_page.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/pages/profile_page.dart';
import 'package:the_movie_booking_app/pages/seating_plan_page.dart';
import 'package:the_movie_booking_app/pages/snack_page.dart';

import 'package:the_movie_booking_app/pages/splash_page.dart';
import 'package:the_movie_booking_app/pages/ticket_information_page.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import 'package:the_movie_booking_app/utils/fonts.dart';

import 'pages/search_movie_page.dart';

void main() async {
  /// Initialize hive
  await Hive.initFlutter();

  /// Register adapters
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  /// Open Hive Box
  await Hive.openBox<MovieVO>(kBoxNameMovieVO);

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
