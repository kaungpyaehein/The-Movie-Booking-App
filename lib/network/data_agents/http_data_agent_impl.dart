import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/data_agents/movie_booking_data_agent.dart';

class HttpDataAgentImpl extends MovieBookingDataAgent{
  @override
  void getNowPlayingMovies(int page) {
    // Create a query parameters ad Map of String, String
    Map<String, String> queryParameters = {
      kParamApiKey: kApiKey,
      kParamLanguage: kLanguageENUS,
      kParamPage: page.toString(),
    };

    // get a url using baseurl , endpoint and query parameters ,use Uri.http or Uri.https depends on baseurl
    var url = Uri.https(
      kBaseUrlHttp,
      kEndPointGetNowPlaying,
      queryParameters,
    );

    // use http as http
    http.get(url).then((response) {
      debugPrint("Now Playing Movies HTTP =======> ${response.body.toString()}");
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
