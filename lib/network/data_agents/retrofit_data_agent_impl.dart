import 'package:dio/dio.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/data_agents/the_movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/network/the_movie_booking_api.dart';

class RetrofitDataAgentImpl extends TheMovieBookingDataAgent {
  //moving booking api is an object dependency
  late TheMovieBookingApi mApi;

  //setup singleton
  static RetrofitDataAgentImpl? _singleton;

  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieBookingApi(dio);
  }

  @override
  Future<List<MovieVO>> getComingSoonMovies(String page) {
    //transform to stream and get results data
    //got stream<List<MovieVO>>
    //then transform back to future by getting the first one
    return mApi
        .getComingSoonMovies(kApiKey, kLanguageENUS, page)
        .asStream()
        .map((response) => response?.results ?? [])
        .first;
    //first of stream means the Future
  }

  @override
  Future<List<CreditVO>> getCreditsByMovie(String movieId) {
    return mApi
        .getCreditsByMovie(movieId, kApiKey, kLanguageENUS, 1.toString())
        .asStream()
        .map((response) => response?.cast ?? [])
        .first;
  }

  @override
  Future<MovieVO> getMovieDetails(String movieId) {
    return mApi.getMovieDetails(movieId, kApiKey, kLanguageENUS);
  }

  @override
  Future<List<MovieVO>> getNowPlayingMovies(String page) {
    return mApi
        .getNowPlayingMoves(kApiKey, kLanguageENUS, page)
        .asStream()
        .map((response) => response?.results ?? [])
        .first;
  }
}
