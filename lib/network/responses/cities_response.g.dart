// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CitiesResponse _$CitiesResponseFromJson(Map<String, dynamic> json) =>
    CitiesResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CityVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CitiesResponseToJson(CitiesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
