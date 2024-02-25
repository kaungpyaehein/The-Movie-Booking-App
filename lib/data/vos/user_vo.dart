import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeUserVO, adapterName: kAdapterNameUserVO)
class UserVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "email")
  @HiveField(2)
  String? email;

  @JsonKey(name: "phone")
  @HiveField(3)
  String? phone;

  @JsonKey(name: "total_expense")
  @HiveField(4)
  int? totalExpense;

  @JsonKey(name: "profile_image")
  @HiveField(5)
  String? profileImage;

  @JsonKey(name: "token")
  @HiveField(6)
  String? token;

  UserVO({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.totalExpense,
    this.profileImage,
    this.token,
  });

  //from json
  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
