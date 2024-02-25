// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_and_show_time_by_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaAndShowTimeByDateResponse _$CinemaAndShowTimeByDateResponseFromJson(
        Map<String, dynamic> json) =>
    CinemaAndShowTimeByDateResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CinemaVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaAndShowTimeByDateResponseToJson(
        CinemaAndShowTimeByDateResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
