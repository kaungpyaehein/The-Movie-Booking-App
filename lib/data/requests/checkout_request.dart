import 'package:json_annotation/json_annotation.dart';

import '../vos/snack_vo.dart';

part 'checkout_request.g.dart';

@JsonSerializable()
class CheckoutRequest {
  //key is case-sensitive and should be identical
  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeslotId;

  @JsonKey(name: "seat_number")
  String? seatNumber;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "payment_type_id")
  int? paymentTypeId;

  @JsonKey(name: "snacks")
  List<SnackVO>? snacks;

  CheckoutRequest(
      {this.cinemaDayTimeslotId,
      this.seatNumber,
      this.bookingDate,
      this.movieId,
      this.paymentTypeId,
      this.snacks});
  //from json
  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}
