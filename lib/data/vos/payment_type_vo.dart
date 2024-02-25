import 'package:json_annotation/json_annotation.dart';

part 'payment_type_vo.g.dart';

@JsonSerializable()
class PaymentTypeVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "icon")
  String? icon;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "delete_at")
  String? deleteAt;

  PaymentTypeVO(
      {this.id,
      this.title,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.deleteAt});

  //from json
  factory PaymentTypeVO.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$PaymentTypeVOToJson(this);
}
