import 'dart:convert';

import 'package:floor/floor.dart';

class GenreIdListTypeConverter extends TypeConverter<List<int>?, String?> {
  @override
  List<int>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    return (json.decode(databaseValue) as List<dynamic>)
        .map((e) => e as int)
        .toList();
  }

  @override
  String? encode(List<int>? value) {
    if(value == null) {
      return null;
    }
    return json.encode(value);
  }
}
