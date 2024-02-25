// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityVO _$CityVOFromJson(Map<String, dynamic> json) => CityVO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CityVOToJson(CityVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
