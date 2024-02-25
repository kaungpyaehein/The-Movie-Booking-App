import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

part 'snack_category_response.g.dart';

@JsonSerializable()
class SnackCategoryResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<SnackCategoryVO>? data;

  SnackCategoryResponse({this.code, this.message, this.data});

  //from json
  factory SnackCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SnackCategoryResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SnackCategoryResponseToJson(this);
}
