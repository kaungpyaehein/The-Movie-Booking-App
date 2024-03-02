import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_booking_app/data/vos/checkout_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/the_movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/network/responses/otp_response.dart';
import 'package:the_movie_booking_app/persistence/cities_dao.dart';
import 'package:the_movie_booking_app/persistence/movie_dao.dart';
import 'package:the_movie_booking_app/persistence/user_dao.dart';

import '../../network/requests/checkout_request.dart';
import '../vos/choose_date_vo.dart';
import '../vos/city_vo.dart';

class MovieBookingModel {
  static MovieBookingModel? _singleton;

  factory MovieBookingModel() {
    _singleton ??= MovieBookingModel._internal();
    return _singleton!;
  }
  MovieBookingModel._internal();

  /// Dao of Hive or Dependency of Persistence Layer
  final MovieDao _movieDao = MovieDao();

  final UserDao _userDao = UserDao();

  final CitiesDao _citiesDao = CitiesDao();

  // /Data agent or Dependency of Network Layer
  TheMovieBookingDataAgent mDataAgent = RetrofitDataAgentImpl();

  Future<List<MovieVO>> getNowPlayingMovies() {
    return mDataAgent
        .getNowPlayingMovies(1.toString())
        .then((nowPlayingMovieList) async {
      /// add type to the move list
      for (var movie in nowPlayingMovieList) {
        movie.type = kMovieTypeNowPlaying;
      }

      /// save movies to hive
      _movieDao.saveMovies(nowPlayingMovieList);
      return nowPlayingMovieList;
    });
  }

  Future<List<MovieVO>> getComingSoonMovies() {
    return mDataAgent
        .getComingSoonMovies(1.toString())
        .then((comingSoonMovieList) async {
      /// add type to the move list
      for (var movie in comingSoonMovieList) {
        movie.type = kMovieTypeComingSoon;
      }

      /// save movies to hive
      _movieDao.saveMovies(comingSoonMovieList);

      return comingSoonMovieList;
    });
  }

  /// Sign in and save user data
  Future<MovieVO> getMovieDetails(String movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      /// save movie to hive
      _movieDao.saveSingleMovie(movie);
      return movie;
    });
  }

  /// Get OTP from network
  Future<OtpResponse> getOtpResponse(String phone) {
    return mDataAgent.getOtp(phone);
  }

  /// Get cities from network and save in local storage
  Future<List<CityVO>> getCities() {
    return mDataAgent.getCities().then((cities) async {
      _citiesDao.saveCities(cities);
      return cities;
    });
  }

  /// Get cinemas and show time by date
  Future<List<CinemaVO>> getCinemasAndShowTimeByDate(String date) {
    return mDataAgent.getCinemasAndShowTimeByDate(date, getBearerToken());
  }

  /// Get snack categories from network
  Future<List<SnackCategoryVO>> getSnackCategories() {
    return mDataAgent.getSnackCategories(getBearerToken());
  }

  // Get snack by category id
  Future<List<SnackVO>> getSnacksByCategoryId(String categoryId) {
    return mDataAgent.getSnacksByCategoryId(categoryId, getBearerToken());
  }

  /// Get seating plan by showtime
  Future<List<SeatVO>> getSeatingPlanByShowTime(
    String cinemaDayTimeslotId,
    String bookingDate,
  ) {
    return mDataAgent.getSeatingPlanByShowTime(
        cinemaDayTimeslotId, bookingDate, getBearerToken());
  }

  /// Get payment types from network
  Future<List<PaymentTypeVO>> getPaymentTypes() {
    return mDataAgent.getPaymentTypes(getBearerToken());
  }

  /// checkout
  Future<CheckoutVO>? checkout(CheckoutRequest checkoutRequest) {
    return mDataAgent.checkout(
      getBearerToken(),
      checkoutRequest,
    );
  }

  /// Get OTP from network
  Future<UserVO> signInWithPhone(String phone, String otp) {
    return mDataAgent.signInWithPhone(phone, otp).then((userData) async {
      // save the user data
      _userDao.saveUserData(userData);
      return userData;
    });
  }

  /// Get Now Playing Movies from Hive
  List<MovieVO> getNowPlayingMoviesFromDatabase() {
    return _movieDao.getMoviesByType(kMovieTypeNowPlaying);
  }

  /// Get Coming Soon Movies from Hive
  List<MovieVO> getComingSoonMoviesFromDatabase() {
    return _movieDao.getMoviesByType(kMovieTypeComingSoon);
  }

  /// Get Movie by ID from hive
  MovieVO? getMovieByIdFromDatabase(int movieId) {
    return _movieDao.getMovieById(movieId);
  }

  /// Get User data from hive
  UserVO? getUserDataFromDatabase() {
    return _userDao.getUserData();
  }

  /// Get CityList  from hive
  List<CityVO> getCitiesFromDatabase() {
    return _citiesDao.getCities();
  }

  // String getBearerToken() {
  //   return getUserDataFromDatabase()?.token ?? "";
  // }

  /// Get City by ID from hive
  CityVO? getCityByIdFromDatabase(int cityId) {
    return _citiesDao.getCityById(cityId);
  }

  Future<List<CreditVO>> getCreditsByMovie(String movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  String getBearerToken() {
    return "Bearer ${_userDao.getToken() ?? ""}";
  }

  /// Get 2 weeks of dates
  List<ChooseDateVO> getTwoWeeksOfDates() {
    List<DateTime> dates = [];
    List<ChooseDateVO> chooseDateVos = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 14; i++) {
      DateTime date = now.add(Duration(days: i));
      dates.add(date);
    }
    chooseDateVos = dates
        .map((date) => ChooseDateVO(formatDefaultDate(date), false))
        .toList();
    return chooseDateVos;
  }

  //date format 1
  String formatDefaultDate(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
}
