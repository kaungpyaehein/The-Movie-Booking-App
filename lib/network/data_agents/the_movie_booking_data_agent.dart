import 'package:the_movie_booking_app/data/requests/checkout_request.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:the_movie_booking_app/data/vos/seat_vos.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/network/responses/otp_response.dart';

import '../../data/vos/checkout_vo.dart';
import '../../data/vos/movie_vo.dart';
import '../../data/vos/seat_vo.dart';
import '../../data/vos/user_vo.dart';

abstract class TheMovieBookingDataAgent {
  Future<List<MovieVO>> getNowPlayingMovies(String page);
  Future<List<MovieVO>> getComingSoonMovies(String page);
  Future<MovieVO> getMovieDetails(String movieId);
  Future<List<CreditVO>> getCreditsByMovie(String movieId);

  // new methods
  Future<OtpResponse> getOtp(String phone);
  Future<UserVO> signInWithPhone(String phone, String otp);
  Future<List<CityVO>> getCities();
  Future<List<SnackVO>> getSnacksByCategoryId(String categoryId);
  Future<List<SnackCategoryVO>> getSnackCategories();
  Future<List<PaymentTypeVO>> getPaymentTypes();
  Future<List<CinemaVO>> getCinemasAndShowTimeByDate(String date);
  Future<List<SeatVO>> getSeatingPlanByShowTime(
      String cinemaDayTimeslotId, String bookingDate);
  Future<CheckoutVO> checkout(CheckoutRequest checkoutRequest);
}
