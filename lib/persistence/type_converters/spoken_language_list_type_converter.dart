import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';

class SpokenLanguageListConverter
    extends TypeConverter<List<SpokenLanguageVO>?, String?> {
  @override
  List<SpokenLanguageVO>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    List<dynamic> decodedList = json.decode(databaseValue);

    List<SpokenLanguageVO> spokenLanguages = decodedList.map((model) {
      return SpokenLanguageVO.fromJson(model as Map<String, dynamic>);
    }).toList();
    return spokenLanguages;
  }

  @override
  String? encode(List<SpokenLanguageVO>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.map((language) => language.toJson()).toList());
  }
}
