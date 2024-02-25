import 'package:json_annotation/json_annotation.dart';

part 'city_vo.g.dart';

@JsonSerializable()
class CityVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  CityVO({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  //from json
  factory CityVO.fromJson(Map<String, dynamic> json) => _$CityVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CityVOToJson(this);
}
