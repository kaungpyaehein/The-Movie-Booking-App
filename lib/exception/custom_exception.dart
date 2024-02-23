import 'package:the_movie_booking_app/data/vos/error_vo.dart';

class CustomException implements Exception {
  final ErrorVO errorVO;

  CustomException(this.errorVO);

  @override
  String toString() => errorVO.statusMessage;
}
