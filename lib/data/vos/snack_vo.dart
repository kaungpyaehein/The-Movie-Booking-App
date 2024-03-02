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

  // @JsonKey(name: "unit_price")
  // int? unitPrice;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "quantity")
  int quantity;

  // @JsonKey(includeFromJson: false, includeToJson: false)
  // int? totalPrice;

  // create total price function
  // subtotal = price * quantity

  SnackVO({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.image,
    this.quantity = 0,
  });
  //from json
  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$SnackVOToJson(this);

  /// GET Subtotal
  int getSubtotal() {
    if (price != null) {
      return price! * quantity!;
    } else {
      return 0;
    }
  }
  SnackVO copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? categoryId,
    String? image,
    int? quantity,
  }) {
    return SnackVO(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
