// import 'package:floor/floor.dart';
// import '../../data/vos/movie_vo.dart';
//
// @dao
// abstract class MovieDao {
//   /// Insert movie list to database local
//   @Insert(onConflict: OnConflictStrategy.replace)
//   Future<void> insertMovieList(List<MovieVO> movie);
//
//   /// Insert movie to local database
//   @Insert(onConflict: OnConflictStrategy.replace)
//   Future<void> insertMovie(MovieVO movie);
//
//   /// get movie by its id
//   @Query("SELECT * FROM movies WHERE id=:movieId")
//   Future<MovieVO?> getMovieById(int movieId);
//
//   /// get movie by its type
//   @Query("SELECT * FROM movies WHERE type=:type")
//   Future<List<MovieVO>> getMoviesByType(String type);
// }
