import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/data_agents/the_movie_booking_data_agent.dart';

class MovieBookingModel {
  static MovieBookingModel? _singleton;

  factory MovieBookingModel() {
    _singleton ??= MovieBookingModel._internal();
    return _singleton!;
  }
  MovieBookingModel._internal();

  //data agent
  TheMovieBookingDataAgent mDataAgent = RetrofitDataAgentImpl();

  Future<List<MovieVO>> getNowPlayingMovies() {
    return mDataAgent
        .getNowPlayingMovies(1.toString())
        .then((nowPlayingMovieList) async {
      // //database
      // var database = await MovieBookingDatabase.getMovieBookingDatabase;
      //
      // // change type of movie in each movie in database
      // for (var movie in nowPlayingMovieList) {
      //   movie.type = kMovieTypeNowPlaying;
      // }
      //
      // // insert now playing movie in database
      // database.movieDao.insertMovieList(nowPlayingMovieList);
      //
      return nowPlayingMovieList;
    });
  }

  Future<List<MovieVO>> getComingSoonMovies() {
    return mDataAgent
        .getComingSoonMovies(1.toString())
        .then((comingSoonMovieList) async {
      // //database
      // var database = await MovieBookingDatabase.getMovieBookingDatabase;
      // // insert type of movie in each movie in database
      // for (var movie in comingSoonMovieList) {
      //   movie.type = kMovieTypeComingSoon;
      // }
      //
      // database.movieDao.insertMovieList(comingSoonMovieList);

      return comingSoonMovieList;
    });
  }

  Future<MovieVO> getMovieDetails(String movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      // //database
      // var database = await MovieBookingDatabase.getMovieBookingDatabase;
      //
      // database.movieDao.insertMovie(movie);

      return movie;
    });
  }

  // /// Get Now Playing Movies from Database
  // Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() async {
  //   var database = await MovieBookingDatabase.getMovieBookingDatabase;
  //
  //   return database.movieDao.getMoviesByType(kMovieTypeNowPlaying);
  // }
  //
  // /// Get Coming Soon Movies from Database
  // Future<List<MovieVO>> getComingSoonMoviesFromDatabase() async {
  //   var database = await MovieBookingDatabase.getMovieBookingDatabase;
  //   return database.movieDao.getMoviesByType(kMovieTypeComingSoon);
  // }
  //
  // /// Get Movie by ID from database
  // Future<MovieVO?> getMovieByIdFromDatabase(int movieId) async {
  //   var database = await MovieBookingDatabase.getMovieBookingDatabase;
  //   return database.movieDao.getMovieById(movieId);
  // }

  Future<List<CreditVO>> getCreditsByMovie(String movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }
}
