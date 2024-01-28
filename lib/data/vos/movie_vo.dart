import 'package:the_movie_booking_app/data/vos/collection_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_contry_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';

class MovieVO {
  bool? adult;

  String? backdropPath;

  CollectionVO? belongsToCollection;

  double? budget;

  List<GenreVO>? genres;

  String? homepage;

  List<int>? genresIds;

  int? id;

  String? imdbId;

  String? originalLanguage;

  String? originalTitle;

  String? overview;

  double? popularity;

  String? posterPath;

  List<ProductionCompanyVO>? productionCompanies;


  List<ProductionCountryVO>? productionCountries;

  String? releaseDate;

  double? revenue;

  int? runtime;

  List<SpokenLanguageVO>? spokenLanguages;

  String? status;

  String? tagline;

  String? title;

  bool? video;

  double? voteAverage;

  int? voteCount;

  MovieVO(
      this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.genresIds,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);
}
