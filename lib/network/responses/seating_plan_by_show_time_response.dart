import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';

part 'seating_plan_by_show_time_response.g.dart';

@JsonSerializable()
class SeatingPlanByShowTimeResponse {
  //key is case-sensitive and should be identical
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<List<SeatVO>?> data;

  SeatingPlanByShowTimeResponse(this.code, this.message, this.data);

  //from json
  factory SeatingPlanByShowTimeResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatingPlanByShowTimeResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SeatingPlanByShowTimeResponseToJson(this);
}
