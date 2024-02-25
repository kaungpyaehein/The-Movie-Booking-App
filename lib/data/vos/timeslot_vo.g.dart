// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeslotVO _$TimeslotVOFromJson(Map<String, dynamic> json) => TimeslotVO(
      cinemaDayTimeslotId: json['cinema_day_timeslot_id'] as int?,
      startTime: json['start_time'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$TimeslotVOToJson(TimeslotVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeslotId,
      'start_time': instance.startTime,
      'status': instance.status,
    };
