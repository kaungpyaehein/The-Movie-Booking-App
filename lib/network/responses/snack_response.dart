import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

part 'snack_response.g.dart';

@JsonSerializable()
class SnackResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<SnackVO>? data;

  SnackResponse({this.code, this.message, this.data});

  //from json
  factory SnackResponse.fromJson(Map<String, dynamic> json) =>
      _$SnackResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SnackResponseToJson(this);
}
