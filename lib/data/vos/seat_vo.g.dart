// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatVO _$SeatVOFromJson(Map<String, dynamic> json) => SeatVO(
      id: json['id'] as int?,
      type: json['type'] as String?,
      seatName: json['seat_name'] as String?,
      symbol: json['symbol'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$SeatVOToJson(SeatVO instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
    };
