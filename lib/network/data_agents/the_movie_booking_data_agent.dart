import 'package:the_movie_booking_app/data/vos/credit_vo.dart';

import '../../data/vos/movie_vo.dart';

abstract class TheMovieBookingDataAgent {
  Future<List<MovieVO>> getNowPlayingMovies(String page);
  Future<List<MovieVO>> getComingSoonMovies(String page);
  Future<MovieVO> getMovieDetails(String movieId);
  Future<List<CreditVO>> getCreditsByMovie(String movieId);
}
