import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  OtpResponse({this.code, this.message});

  //from json
  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}
