import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_type_vo.dart';

part 'payment_type_response.g.dart';

@JsonSerializable()
class PaymentTypeResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<PaymentTypeVO>? data;

  PaymentTypeResponse({this.code, this.message, this.data});

  //from json
  factory PaymentTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$PaymentTypeResponseToJson(this);
}
