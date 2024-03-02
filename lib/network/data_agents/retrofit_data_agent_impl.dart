import 'dart:convert';

import 'package:dio/dio.dart';
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
import 'package:the_movie_booking_app/network/tmba_api.dart';

import '../requests/checkout_request.dart';

class RetrofitDataAgentImpl extends TheMovieBookingDataAgent {
  //moving booking api is an object dependency
  late TheMovieBookingApi mApi;

  late TmbaApi mTmbaApi;

  //setup singleton
  static RetrofitDataAgentImpl? _singleton;

  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieBookingApi(dio);
    mTmbaApi = TmbaApi(dio);
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
    return mApi
        .getMovieDetails(movieId, kApiKey, kLanguageENUS)
        .catchError((error) {
      throw _createException(error);
    });
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
  Future<CheckoutVO> checkout(
      String bearerToken, CheckoutRequest checkoutRequest) {
    return mTmbaApi
        .checkout(bearerToken, kApplicationJson, checkoutRequest)
        .asStream()
        .map((response) => response.data ?? CheckoutVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<CinemaVO>> getCinemasAndShowTimeByDate(
      String date, String bearerToken) {
    return mTmbaApi
        .getCinemaAndShowTimeByDate(date, bearerToken)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<CityVO>> getCities() {
    return mTmbaApi
        .getCities()
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<OtpResponse> getOtp(String phone) {
    return mTmbaApi.getOtp(phone).catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<PaymentTypeVO>> getPaymentTypes(
    String bearerToken,
  ) {
    return mTmbaApi
        .getPaymentTypes(bearerToken, kApplicationJson)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<SeatVO>> getSeatingPlanByShowTime(
      String cinemaDayTimeslotId, String bookingDate, String bearerToken) {
    return mTmbaApi
        .getSeatingPlanByShowTime(cinemaDayTimeslotId, bookingDate, bearerToken)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<SnackCategoryVO>> getSnackCategories(String bearerToken) {
    return mTmbaApi
        .getSnackCategory(bearerToken)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<SnackVO>> getSnacksByCategoryId(
      String categoryId, String bearerToken) {
    return mTmbaApi
        .getSnacks(categoryId, kApplicationJson, bearerToken)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<UserVO> signInWithPhone(String phone, String otp) {
    return mTmbaApi
        .signInWithPhone(phone, otp)
        .asStream()
        .map((signInResponse) {
          var response = signInResponse.data;
          return UserVO(
            id: response?.id ?? 0,
            email: response?.email ?? "",
            name: response?.name ?? "",
            phone: response?.phone ?? "",
            profileImage: response?.profileImage ?? "",
            totalExpense: response?.totalExpense ?? 0,
            token: response?.token ?? "",
          );
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
    // return mTmbaApi.signInWithPhone(phone, otp).then((userResponse) {
    //   var responseData = userResponse.data;
    //
    //   return UserVO(
    //     id: responseData?.id ?? 0,
    //     email: responseData?.email ?? "",
    //     name: responseData?.name ?? "",
    //     phone: responseData?.phone ?? "",
    //     profileImage: responseData?.profileImage ?? "",
    //     totalExpense: responseData?.totalExpense ?? 0,
    //     token: userResponse.token ?? "",
    //   );
    // });
  }
}
