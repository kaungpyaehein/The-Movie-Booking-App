import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';

class ProductionCompanyListConverter
    extends TypeConverter<List<ProductionCompanyVO>?, String?> {
  @override
  List<ProductionCompanyVO>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    List<dynamic> decodedList = json.decode(databaseValue);

    List<ProductionCompanyVO> productionCompanies = decodedList.map((model) {
      return ProductionCompanyVO.fromJson(model as Map<String, dynamic>);
    }).toList();
    return productionCompanies;
  }

  @override
  String? encode(List<ProductionCompanyVO>? value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.map((company) => company.toJson()).toList());
  }
}
