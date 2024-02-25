import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/the_movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/persistence/movie_dao.dart';

class MovieBookingModel {
  static MovieBookingModel? _singleton;

  factory MovieBookingModel() {
    _singleton ??= MovieBookingModel._internal();
    return _singleton!;
  }
  MovieBookingModel._internal();

  /// Dao of Hive or Dependency of Persistence Layer
  final MovieDao _movieDao = MovieDao();

  // /Data agent or Dependency of Network Layer
  TheMovieBookingDataAgent mDataAgent = RetrofitDataAgentImpl();

  Future<List<MovieVO>> getNowPlayingMovies() {
    return mDataAgent
        .getNowPlayingMovies(1.toString())
        .then((nowPlayingMovieList) async {
      /// add type to the move list
      for (var movie in nowPlayingMovieList) {
        movie.type = kMovieTypeNowPlaying;
      }

      /// save movies to hive
      _movieDao.saveMovies(nowPlayingMovieList);
      return nowPlayingMovieList;
    });
  }

  Future<List<MovieVO>> getComingSoonMovies() {
    return mDataAgent
        .getComingSoonMovies(1.toString())
        .then((comingSoonMovieList) async {
      /// add type to the move list
      for (var movie in comingSoonMovieList) {
        movie.type = kMovieTypeComingSoon;
      }

      /// save movies to hive
      _movieDao.saveMovies(comingSoonMovieList);

      return comingSoonMovieList;
    });
  }

  Future<MovieVO> getMovieDetails(String movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      /// save movie to hive
      _movieDao.saveSingleMove(movie);
      return movie;
    });
  }

  /// Get Now Playing Movies from Hive
  List<MovieVO> getNowPlayingMoviesFromDatabase() {
    return _movieDao.getMoviesByType(kMovieTypeNowPlaying);
  }

  /// Get Coming Soon Movies from Hive
  List<MovieVO> getComingSoonMoviesFromDatabase() {
    return _movieDao.getMoviesByType(kMovieTypeComingSoon);
  }

  /// Get Movie by ID from hive
  MovieVO? getMovieByIdFromDatabase(int movieId) {
    return _movieDao.getMovieById(movieId);
  }

  Future<List<CreditVO>> getCreditsByMovie(String movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }
}
