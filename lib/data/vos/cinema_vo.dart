import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';

part 'cinema_vo.g.dart';

@JsonSerializable()
class CinemaVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "cinema")
  String? cinema;

  @JsonKey(name: "timeslots")
  List<TimeslotVO>? timeslots;

  CinemaVO({this.cinemaId, this.cinema, this.timeslots});

  //from json
  factory CinemaVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CinemaVOToJson(this);
}
