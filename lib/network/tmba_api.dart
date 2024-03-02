import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/requests/checkout_request.dart';
import 'package:the_movie_booking_app/network/responses/checkout_response.dart';
import 'package:the_movie_booking_app/network/responses/cinema_and_show_time_by_date_response.dart';
import 'package:the_movie_booking_app/network/responses/cities_response.dart';
import 'package:the_movie_booking_app/network/responses/otp_response.dart';
import 'package:the_movie_booking_app/network/responses/payment_type_response.dart';
import 'package:the_movie_booking_app/network/responses/seating_plan_by_show_time_response.dart';
import 'package:the_movie_booking_app/network/responses/snack_category_response.dart';
import 'package:the_movie_booking_app/network/responses/snack_response.dart';

import 'responses/sign_in_with_phone_response.dart';

part 'tmba_api.g.dart';

@RestApi(baseUrl: kNewBaseUrl)
abstract class TmbaApi {
  factory TmbaApi(Dio dio) = _TmbaApi;

  /// GET OTP
  @POST(kEndPointGetOtp)
  @FormUrlEncoded()
  Future<OtpResponse> getOtp(
    @Field(kFieldPhone) String phone,
  );

  /// SIGN IN WITH PHONE NUMBER
  @POST(kEndPointSignInWithPhone)
  @FormUrlEncoded()
  Future<SignInWithPhoneResponse> signInWithPhone(
    @Field(kFieldPhone) String phone,
    @Field(kFieldOtp) String otp,
  );

  /// GET CITIES
  @GET(kEndPointGetCities)
  Future<CitiesResponse> getCities();

  /// GET SNACKS
  @GET(kEndPointGetSnacks)
  Future<SnackResponse> getSnacks(
    @Query(kParamCategoryId) String categoryId,
    @Header(kHeaderAccept) String accept,
    @Header(kHeaderAuthorization) String bearerToken,
  );

  /// GET CINEMA AND SHOW TIME BY DATE
  @GET(kEndPointGetCinemaAndShowTimeByDate)
  Future<CinemaAndShowTimeByDateResponse> getCinemaAndShowTimeByDate(
    @Query(kParamDate) String date,
    @Header(kHeaderAuthorization) String bearerToken,
  );

  /// GET SEATING PLAN BY SHOW TIME
  @GET(kEndPointGetSeatingPlanByShowTime)
  Future<SeatingPlanByShowTimeResponse> getSeatingPlanByShowTime(
    @Query(kParamCinemaDayTimeslotId) String cinemaDayTimeslotId,
    @Query(kParamBookingDate) String bookingDate,
    @Header(kHeaderAuthorization) String bearerToken,
  );

  /// GET SNACK CATEGORIES
  @GET(kEndPointGetSnackCategories)
  Future<SnackCategoryResponse> getSnackCategory(
    @Header(kHeaderAuthorization) String bearerToken,
  );

  /// GET PAYMENT TYPES
  @GET(kEndPointGetPaymentTypes)
  Future<PaymentTypeResponse> getPaymentTypes(
    @Header(kHeaderAuthorization) String bearerToken,
    @Header(kHeaderAccept) String accept,
  );

  /// CHECKOUT
  @POST(kEndPointCheckout)
  Future<CheckoutResponse> checkout(
    @Header(kHeaderAuthorization) String bearerToken,
    @Header(kHeaderAccept) String accept,
    @Body() CheckoutRequest checkoutRequest,
  );
}
