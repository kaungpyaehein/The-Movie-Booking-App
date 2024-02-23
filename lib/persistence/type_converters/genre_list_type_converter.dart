import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';

class GenreListTypeConverter extends TypeConverter<List<GenreVO>?, String?> {
  @override
  List<GenreVO>? decode(String? databaseValue) {
    if (databaseValue == null) {
      // debugPrint("GenreListTypeConverter : $databaseValue");
      return null;
    }

    // Convert to List<Map<String, dynamic>>
    List<dynamic> decodedList = json.decode(databaseValue);

    // Convert to List<GenreVO>
    List<GenreVO> genres = decodedList.map((model) {
      return GenreVO.fromJson(model as Map<String, dynamic>);
    }).toList();

    return genres;
  }

  @override
  String? encode(List<GenreVO>? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.map((genre) => genre.toJson()).toList());
  }
}
