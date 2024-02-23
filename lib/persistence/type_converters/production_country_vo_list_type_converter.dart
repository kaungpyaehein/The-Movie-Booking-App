import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';

class ProductionCountryListTypeConverter
    extends TypeConverter<List<ProductionCountryVO>?, String?> {
  @override
  List<ProductionCountryVO>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    List< dynamic> decodedList = json.decode(databaseValue);

    List<ProductionCountryVO> productionCountries = decodedList.map((model) {
      return ProductionCountryVO.fromJson(model as Map<String, dynamic>);
    }).toList();
    return productionCountries;
  }

  @override
  String? encode(List<ProductionCountryVO>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.map((country) => country.toJson()).toList());
  }
}
