// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaVO _$CinemaVOFromJson(Map<String, dynamic> json) => CinemaVO(
      cinemaId: json['cinema_id'] as int?,
      cinema: json['cinema'] as String?,
      timeslots: (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeslotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaVOToJson(CinemaVO instance) => <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeslots,
    };
