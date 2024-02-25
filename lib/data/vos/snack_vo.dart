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
  String? createdAt;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "unit_price")
  int? unitPrice;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "quantity")
  String? quantity;

  @JsonKey(name: "total_price")
  String? totalPrice;


  SnackVO(this.id, this.name, this.createdAt, this.price, this.unitPrice,
      this.categoryId, this.image, this.quantity, this.totalPrice);
  //from json
  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SnackVOToJson(this);

}
