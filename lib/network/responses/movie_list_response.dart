import '../../data/vos/date_vo.dart';
import '../../data/vos/movie_vo.dart';

class MovieListResponse {
  DateVO? dates;

  int? page;

  List<MovieVO>? results;

  MovieListResponse({this.dates, this.page, this.results});
}
