import 'package:json_annotation/json_annotation.dart';

part 'timeslot_vo.g.dart';

@JsonSerializable()
class TimeslotVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeslotId;

  @JsonKey(name: "start_time")
  String? startTime;

  @JsonKey(name: "status")
  int? status;

  TimeslotVO({this.cinemaDayTimeslotId, this.startTime, this.status});

  //from json
  factory TimeslotVO.fromJson(Map<String, dynamic> json) =>
      _$TimeslotVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$TimeslotVOToJson(this);
}
