import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/collection_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

part 'movie_vo.g.dart';

@JsonSerializable()

/// hive type
@HiveType(typeId: kHiveTypeIdMovieVO, adapterName: kAdapterNameMovieVO)
class MovieVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(2)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(3)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(4)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(5)
  String? homepage;

  @JsonKey(name: "genre_ids")
  @HiveField(6)
  List<int>? genresIds;

  @JsonKey(name: "id")
  @HiveField(7)
  int? id;

  @JsonKey(name: "imdb_id")
  @HiveField(8)
  String? imdbId;

  @JsonKey(name: "original_language")
  @HiveField(9)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(10)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(11)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(12)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(13)
  String? posterPath;

  @JsonKey(name: "production_companies")
  @HiveField(14)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(15)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "release_date")
  @HiveField(16)
  String? releaseDate;

  @JsonKey(name: "revenue")
  @HiveField(17)
  double? revenue;

  @JsonKey(name: "runtime")
  @HiveField(18)
  int? runtime;

  @JsonKey(name: "spoken_languages")
  @HiveField(19)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(20)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(21)
  String? tagline;

  @JsonKey(name: "title")
  @HiveField(22)
  String? title;

  @JsonKey(name: "video")
  @HiveField(23)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(24)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(25)
  int? voteCount;

  // ONLY for persistence layer
  // to hide from network call json parse
  // is selected
  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(26)
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
    return kPosterImageBaseUrl + (posterPath ?? "");
  }

  ///backdrop path with base url
  String getBackdropPathWithBaseUrl() {
    return kBackDropImageBaseUrl + (backdropPath ?? "");
  }

  //get rating with two decimal places
  String getRatingTwoDecimals() {
    return voteAverage?.toStringAsFixed(2) ?? "";
  }
}

const String kMovieTypeNowPlaying = "now-playing";
const String kMovieTypeComingSoon = "coming_soon";
