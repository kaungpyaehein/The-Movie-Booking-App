import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:the_movie_booking_app/data/requests/checkout_request.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/error_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/exception/custom_exception.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/data_agents/the_movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/network/responses/otp_response.dart';
import 'package:the_movie_booking_app/network/the_movie_booking_api.dart';

class RetrofitDataAgentImpl extends TheMovieBookingDataAgent {
  //moving booking api is an object dependency
  late TheMovieBookingApi mApi;
  late TheMovieBookingApi mApiWithNewUrl;

  //setup singleton
  static RetrofitDataAgentImpl? _singleton;

  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieBookingApi(dio);
    mApiWithNewUrl = TheMovieBookingApi(dio, baseUrl: kNewBaseUrl);
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
        .getNowPlayingMovies(kApiKey, kLanguageENUS, page)
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

  @override
  Future<CheckoutVO> checkout(CheckoutRequest checkoutRequest) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<List<CinemaVO>> getCinemasAndShowTimeByDate(String date) {
    // TODO: implement getCinemasAndShowTimeByDate
    throw UnimplementedError();
  }

  @override
  Future<List<CityVO>> getCities() {
    // TODO: implement getCities
    throw UnimplementedError();
  }

  @override
  Future<OtpResponse> getOtp(String phone) {
    // TODO: implement getOtp
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentTypeVO>> getPaymentTypes() {
    // TODO: implement getPaymentTypes
    throw UnimplementedError();
  }

  @override
  Future<List<SeatVO>> getSeatingPlanByShowTime(
      String cinemaDayTimeslotId, String bookingDate) {
    // TODO: implement getSeatingPlanByShowTime
    throw UnimplementedError();
  }

  @override
  Future<List<SnackCategoryVO>> getSnackCategories() {
    // TODO: implement getSnackCategories
    throw UnimplementedError();
  }

  @override
  Future<List<SnackVO>> getSnacksByCategoryId(String categoryId) {
    // TODO: implement getSnacksByCategoryId
    throw UnimplementedError();
  }

  @override
  Future<UserVO> signInWithPhone(String phone, String otp) {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }
}
