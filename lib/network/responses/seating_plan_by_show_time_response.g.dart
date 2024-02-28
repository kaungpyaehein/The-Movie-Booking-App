// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seating_plan_by_show_time_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatingPlanByShowTimeResponse _$SeatingPlanByShowTimeResponseFromJson(
        Map<String, dynamic> json) =>
    SeatingPlanByShowTimeResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SeatVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatingPlanByShowTimeResponseToJson(
        SeatingPlanByShowTimeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
