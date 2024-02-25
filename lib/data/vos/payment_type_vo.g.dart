// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeVO _$PaymentTypeVOFromJson(Map<String, dynamic> json) =>
    PaymentTypeVO(
      id: json['id'] as int?,
      title: json['title'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deleteAt: json['delete_at'] as String?,
    );

Map<String, dynamic> _$PaymentTypeVOToJson(PaymentTypeVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'delete_at': instance.deleteAt,
    };
