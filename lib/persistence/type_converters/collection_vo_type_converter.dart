import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:the_movie_booking_app/data/vos/collection_vo.dart';

class CollectionVOTypeConverter extends TypeConverter<CollectionVO?, String?> {
  /// From Json String to Object
  @override
  CollectionVO? decode(String? jsonStringFromDatabase) {
    if (jsonStringFromDatabase == null) {
      return null;
    }
    /// convert String into Map<String, dynamic> by json.decode
    return CollectionVO.fromJson(
        json.decode(jsonStringFromDatabase) as Map<String, dynamic>);
  }

  /// From Object to Json String
  @override
  String? encode(CollectionVO? value) {
    if (value == null) {
      return null;
    }
    /// convert String into Map<String, dynamic> by .toJson
    /// convert again to json string by json.encode
    return json.encode(value.toJson());
  }
}
