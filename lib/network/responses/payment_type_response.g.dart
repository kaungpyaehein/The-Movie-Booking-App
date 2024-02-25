// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeResponse _$PaymentTypeResponseFromJson(Map<String, dynamic> json) =>
    PaymentTypeResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentTypeVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentTypeResponseToJson(
        PaymentTypeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
