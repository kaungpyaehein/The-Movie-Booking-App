import 'package:hive_flutter/adapters.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

import 'hive_constants.dart';

class CitiesDao {
  static final CitiesDao _singleton = CitiesDao._internal();

  factory CitiesDao() {
    return _singleton;
  }
  CitiesDao._internal();

  /// save user data

  // save cities in the database
  void saveCities(List<CityVO> cities) async {
    /// {} represents Map
    Map<int, CityVO> cityMap = {for (var city in cities) city.id ?? 0: city};
    await getCityBox().putAll(cityMap);
  }

  /// get all cities from the database
  List<CityVO> getCities() {
    /// get the values in the box first
    return getCityBox().values.toList();
  }

  CityVO? getCityById(int cityId) {
    return getCityBox().get(cityId);
  }

  /// user box
  Box<CityVO> getCityBox() {
    return Hive.box<CityVO>(kBoxNameCityVO);
  }
}
