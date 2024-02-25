

import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';

part 'cities_response.g.dart';

@JsonSerializable()
class CitiesResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CityVO>? data;

  CitiesResponse({this.code, this.message, this.data});

  //from json
  factory CitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$CitiesResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CitiesResponseToJson(this);
}
