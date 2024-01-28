import 'package:json_annotation/json_annotation.dart';

part 'date_vo.g.dart';

@JsonSerializable()
class DateVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "maximum")
  String? maximum;

  @JsonKey(name: "minimum")
  String? minimum;

  DateVO({this.maximum, this.minimum});

  //from json
  factory DateVO.fromJson(Map<String, dynamic> json) => _$DateVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$DateVOToJson(this);

}
