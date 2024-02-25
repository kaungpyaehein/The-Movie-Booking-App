import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';

import '../../data/vos/checkout_vo.dart';

part 'checkout_response.g.dart';

@JsonSerializable()
class CheckoutResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  CheckoutVO? data;

  CheckoutResponse(this.code, this.message, this.data);
  //from json
  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
