// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackVO _$SnackVOFromJson(Map<String, dynamic> json) => SnackVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['unit_price'] as int?,
      json['category_id'] as int?,
      json['image'] as String?,
      json['quantity'] as String?,
      json['total_price'] as String?,
    );

Map<String, dynamic> _$SnackVOToJson(SnackVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.createdAt,
      'price': instance.price,
      'unit_price': instance.unitPrice,
      'category_id': instance.categoryId,
      'image': instance.image,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
    };
