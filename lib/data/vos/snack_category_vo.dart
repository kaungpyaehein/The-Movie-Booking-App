import 'package:json_annotation/json_annotation.dart';

part 'snack_category_vo.g.dart';

@JsonSerializable()
class SnackCategoryVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "title_mm")
  String? titleMm;

  @JsonKey(name: "is_active")
  int? isActive;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "deleted_at")
  String? deletedAt;
  // is selected needs

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;
  SnackCategoryVO(
      {this.id,
      this.title,
      this.titleMm,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isSelected = false});
  //from json
  factory SnackCategoryVO.fromJson(Map<String, dynamic> json) =>
      _$SnackCategoryVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SnackCategoryVOToJson(this);
}
