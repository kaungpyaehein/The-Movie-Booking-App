import 'package:json_annotation/json_annotation.dart';

part 'snack_vo.g.dart';

@JsonSerializable()
class SnackVO {
  //key is case-sensitive and should be identical
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "unit_price")
  int? unitPrice;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int? quantity;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int? totalPrice;

  SnackVO({
    this.id,
    this.name,
    this.description,
    this.price,
    this.unitPrice,
    this.categoryId,
    this.image,
    this.quantity = 0,
    this.totalPrice = 0,
  });
  //from json
  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SnackVOToJson(this);
}
