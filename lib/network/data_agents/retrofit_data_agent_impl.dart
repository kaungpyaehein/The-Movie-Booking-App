import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/error_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/exception/custom_exception.dart';
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
        .first
        .catchError((error) {
      throw _createException(error);
    });
    //first of stream means the Future
  }

  @override
  Future<List<CreditVO>> getCreditsByMovie(String movieId) {
    return mApi
        .getCreditsByMovie(movieId, kApiKey, kLanguageENUS, 1.toString())
        .asStream()
        .map((response) => response?.cast ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
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
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  CustomException _createException(dynamic error) {
    ErrorVO errorVO;
    if (error is DioException) {
      errorVO = _parseDioError(error);
    } else {
      errorVO = ErrorVO(
          statusCode: 0, statusMessage: "Unexpected Error", success: false);
    }
    return CustomException(errorVO);
  }

  ErrorVO _parseDioError(DioException error) {
    try {
      if (error.response != null && error.response?.data != null) {
        var data = error.response?.data;

        ///Json parsing to map<string,dynamic>
        if (data is String) {
          data = jsonDecode(data);
        }

        /// Map<String,dynamic> to ErrorVO
        return ErrorVO.fromJson(data);
      } else {
        return ErrorVO(
            statusCode: 0, statusMessage: "No response data", success: false);
      }
    } catch (e) {
      return ErrorVO(
          statusCode: 0,
          statusMessage: "Invalid DioException Format $e",
          success: false);
    }
  }
}
