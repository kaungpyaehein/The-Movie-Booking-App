import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/collection_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
// the name of the table
@Entity(tableName: "movies")
class MovieVO {
  @JsonKey(name: "adult")
  // column info will be the same text formant as the Jsonkey
  @ColumnInfo(name: "adult")
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @ColumnInfo(name: "backdrop_path")
  String? backdropPath;

  @JsonKey(name: "belongs_to_collection")
  @ColumnInfo(name: "belongs_to_collection")
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @ColumnInfo(name: "budget")
  double? budget;

  @JsonKey(name: "genres")
  @ColumnInfo(name: "genres")
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @ColumnInfo(name: "homepage")
  String? homepage;

  @JsonKey(name: "genre_ids")
  @ColumnInfo(name: "genre_ids")
  List<int>? genresIds;

  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  // make id as the primary key to be unique
  @PrimaryKey()
  int? id;

  @JsonKey(name: "imdb_id")
  @ColumnInfo(name: "imdb_id")
  String? imdbId;

  @JsonKey(name: "original_language")
  @ColumnInfo(name: "original_language")
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @ColumnInfo(name: "original_title")
  String? originalTitle;

  @JsonKey(name: "overview")
  @ColumnInfo(name: "overview")
  String? overview;

  @JsonKey(name: "popularity")
  @ColumnInfo(name: "popularity")
  double? popularity;

  @JsonKey(name: "poster_path")
  @ColumnInfo(name: "poster_path")
  String? posterPath;

  @JsonKey(name: "production_companies")
  @ColumnInfo(name: "production_companies")
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @ColumnInfo(name: "production_countries")
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "release_date")
  @ColumnInfo(name: "release_date")
  String? releaseDate;

  @JsonKey(name: "revenue")
  @ColumnInfo(name: "revenue")
  double? revenue;

  @JsonKey(name: "runtime")
  @ColumnInfo(name: "runtime")
  int? runtime;

  @JsonKey(name: "spoken_languages")
  @ColumnInfo(name: "spoken_languages")
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @ColumnInfo(name: "status")
  String? status;

  @JsonKey(name: "tagline")
  @ColumnInfo(name: "tagline")
  String? tagline;

  @JsonKey(name: "title")
  @ColumnInfo(name: "title")
  String? title;

  @JsonKey(name: "video")
  @ColumnInfo(name: "video")
  bool? video;

  @JsonKey(name: "vote_average")
  @ColumnInfo(name: "vote_average")
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @ColumnInfo(name: "vote_count")
  int? voteCount;

  // ONLY for persistence layer
  // to hide from network call json parse
  @JsonKey(includeFromJson: false, includeToJson: false)
  @ColumnInfo(name: "type")
  String type;

  MovieVO(
      {this.adult,
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
      this.voteCount,
      this.type = ""});

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  // get runtime formatted
  String getRunTimeFormatted() {
    if (runtime != null) {
      int hours = runtime! ~/ 60;
      int minutes = runtime! % 60;
      return "$hours hr $minutes mins";
    } else {
      return "";
    }
  }

  // get release date formatted
  String getReleaseDateFormatted() {
    if (releaseDate != null) {
      DateTime dateTime = DateTime.parse(releaseDate!);
      String formattedDate = DateFormat('dd MMMM').format(dateTime);
      return formattedDate;
    } else {
      return "";
    }
  }

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  /// Poster Path with base url
  String getPosterPathWithBaseUrl() {
    return kImageBaseUrl + (posterPath ?? "");
  }

  ///backdrop path with base url
  String getBackdropPathWithBaseUrl() {
    return kImageBaseUrl + (backdropPath ?? "");
  }

  //get rating with two decimal places
  String getRatingTwoDecimals() {
    return voteAverage?.toStringAsFixed(2) ?? "";
  }
}

const String kMovieTypeNowPlaying = "now-playing";
const String kMovieTypeComingSoon = "coming_soon";
