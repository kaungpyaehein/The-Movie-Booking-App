import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import '../data/vos/movie_vo.dart';

class MovieDao {
  /// Must be singleton
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }
  MovieDao._internal();

  /// map movie object to movie_id : moves to store in hive
  void saveMovies(List<MovieVO> movies) async {
    /// {} represents Map
    Map<int, MovieVO> movieMap = {
      for (var movie in movies) movie.id ?? 0: movie
    };
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getMoviesByType(String type) {
    /// get the values in the box first
    return getMovieBox().values.where((movie) => movie.type == type).toList();
  }


  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }


  /// Get Movie Box from HIVE
  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(kBoxNameMovieVO);
  }
}
