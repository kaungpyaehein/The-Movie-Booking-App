import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/network/data_agents/movie_booking_data_agent.dart';

import '../api_constants.dart';

class DioMovieDataAgentImpl extends MovieBookingDataAgent{
  @override
  void getNowPlayingMovies(int page) {
    // Create a query parameters ad Map of String, String
    Map<String, String> queryParameters = {
      kParamApiKey: kApiKey,
      kParamLanguage: kLanguageENUS,
      kParamPage: page.toString(),
    };
    
    Dio()
        .get("$kBaseUrl$kEndPointGetNowPlaying",
            queryParameters: queryParameters)
        .then((value) {
      debugPrint("Now Playing Movies Dio =======> ${value.toString()}");
    }).catchError((error) {
      debugPrint("Error =========> ${error.toString()}");
    });
  }

  @override
  void getComingSoonMovies(int page) {
    // TODO: implement getComingSoonMovies
  }

  @override
  void getCreditsByMovie() {
    // TODO: implement getCreditsByMovie
  }

  @override
  void getMovieDetails() {
    // TODO: implement getMovieDetails
  }
}
