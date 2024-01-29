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
    return mDataAgent.getNowPlayingMovies(1.toString());
  }

  Future<List<MovieVO>> getComingSoonMovies() {
    return mDataAgent.getComingSoonMovies(1.toString());
  }

  Future<MovieVO> getMovieDetails(String movieId) {
    return mDataAgent.getMovieDetails(movieId);
  }

  Future<List<CreditVO>> getCreditsByMovie(String movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }
}
