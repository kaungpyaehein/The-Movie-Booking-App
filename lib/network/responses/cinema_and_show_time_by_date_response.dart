import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';

part 'cinema_and_show_time_by_date_response.g.dart';

@JsonSerializable()
class CinemaAndShowTimeByDateResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CinemaVO>? data;
  CinemaAndShowTimeByDateResponse({
    this.code,
    this.message,
    this.data,
  });

  //from json
  factory CinemaAndShowTimeByDateResponse.fromJson(Map<String, dynamic> json) =>
      _$CinemaAndShowTimeByDateResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() =>
      _$CinemaAndShowTimeByDateResponseToJson(this);
}
