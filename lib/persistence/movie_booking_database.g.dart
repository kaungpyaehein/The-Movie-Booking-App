// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_booking_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMovieBookingDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieBookingDatabaseBuilder databaseBuilder(String name) =>
      _$MovieBookingDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieBookingDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MovieBookingDatabaseBuilder(null);
}

class _$MovieBookingDatabaseBuilder {
  _$MovieBookingDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MovieBookingDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MovieBookingDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MovieBookingDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieBookingDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieBookingDatabase extends MovieBookingDatabase {
  _$MovieBookingDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movies` (`adult` INTEGER, `backdrop_path` TEXT, `belongs_to_collection` TEXT, `budget` REAL, `genres` TEXT, `homepage` TEXT, `genre_ids` TEXT, `id` INTEGER, `imdb_id` TEXT, `original_language` TEXT, `original_title` TEXT, `overview` TEXT, `popularity` REAL, `poster_path` TEXT, `production_companies` TEXT, `production_countries` TEXT, `release_date` TEXT, `revenue` REAL, `runtime` INTEGER, `spoken_languages` TEXT, `status` TEXT, `tagline` TEXT, `title` TEXT, `video` INTEGER, `vote_average` REAL, `vote_count` INTEGER, `type` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieVOInsertionAdapter = InsertionAdapter(
            database,
            'movies',
            (MovieVO item) => <String, Object?>{
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'backdrop_path': item.backdropPath,
                  'belongs_to_collection': _collectionVOTypeConverter
                      .encode(item.belongsToCollection),
                  'budget': item.budget,
                  'genres': _genreListTypeConverter.encode(item.genres),
                  'homepage': item.homepage,
                  'genre_ids': _genreIdListTypeConverter.encode(item.genresIds),
                  'id': item.id,
                  'imdb_id': item.imdbId,
                  'original_language': item.originalLanguage,
                  'original_title': item.originalTitle,
                  'overview': item.overview,
                  'popularity': item.popularity,
                  'poster_path': item.posterPath,
                  'production_companies': _productionCompanyListConverter
                      .encode(item.productionCompanies),
                  'production_countries': _productionCountryListTypeConverter
                      .encode(item.productionCountries),
                  'release_date': item.releaseDate,
                  'revenue': item.revenue,
                  'runtime': item.runtime,
                  'spoken_languages':
                      _spokenLanguageListConverter.encode(item.spokenLanguages),
                  'status': item.status,
                  'tagline': item.tagline,
                  'title': item.title,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'vote_average': item.voteAverage,
                  'vote_count': item.voteCount,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieVO> _movieVOInsertionAdapter;

  @override
  Future<MovieVO?> getMovieById(int movieId) async {
    return _queryAdapter.query('SELECT * FROM movies WHERE id=?1',
        mapper: (Map<String, Object?> row) => MovieVO(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdrop_path'] as String?,
            belongsToCollection: _collectionVOTypeConverter
                .decode(row['belongs_to_collection'] as String?),
            budget: row['budget'] as double?,
            genres: _genreListTypeConverter.decode(row['genres'] as String?),
            homepage: row['homepage'] as String?,
            genresIds:
                _genreIdListTypeConverter.decode(row['genre_ids'] as String?),
            id: row['id'] as int?,
            imdbId: row['imdb_id'] as String?,
            originalLanguage: row['original_language'] as String?,
            originalTitle: row['original_title'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as double?,
            posterPath: row['poster_path'] as String?,
            productionCompanies: _productionCompanyListConverter
                .decode(row['production_companies'] as String?),
            productionCountries: _productionCountryListTypeConverter
                .decode(row['production_countries'] as String?),
            releaseDate: row['release_date'] as String?,
            revenue: row['revenue'] as double?,
            runtime: row['runtime'] as int?,
            spokenLanguages: _spokenLanguageListConverter
                .decode(row['spoken_languages'] as String?),
            status: row['status'] as String?,
            tagline: row['tagline'] as String?,
            title: row['title'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['vote_average'] as double?,
            voteCount: row['vote_count'] as int?,
            type: row['type'] as String),
        arguments: [movieId]);
  }

  @override
  Future<List<MovieVO>> getMoviesByType(String type) async {
    return _queryAdapter.queryList('SELECT * FROM movies WHERE type=?1',
        mapper: (Map<String, Object?> row) => MovieVO(
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            backdropPath: row['backdrop_path'] as String?,
            belongsToCollection: _collectionVOTypeConverter
                .decode(row['belongs_to_collection'] as String?),
            budget: row['budget'] as double?,
            genres: _genreListTypeConverter.decode(row['genres'] as String?),
            homepage: row['homepage'] as String?,
            genresIds:
                _genreIdListTypeConverter.decode(row['genre_ids'] as String?),
            id: row['id'] as int?,
            imdbId: row['imdb_id'] as String?,
            originalLanguage: row['original_language'] as String?,
            originalTitle: row['original_title'] as String?,
            overview: row['overview'] as String?,
            popularity: row['popularity'] as double?,
            posterPath: row['poster_path'] as String?,
            productionCompanies: _productionCompanyListConverter
                .decode(row['production_companies'] as String?),
            productionCountries: _productionCountryListTypeConverter
                .decode(row['production_countries'] as String?),
            releaseDate: row['release_date'] as String?,
            revenue: row['revenue'] as double?,
            runtime: row['runtime'] as int?,
            spokenLanguages: _spokenLanguageListConverter
                .decode(row['spoken_languages'] as String?),
            status: row['status'] as String?,
            tagline: row['tagline'] as String?,
            title: row['title'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['vote_average'] as double?,
            voteCount: row['vote_count'] as int?,
            type: row['type'] as String),
        arguments: [type]);
  }

  @override
  Future<void> insertMovieList(List<MovieVO> movie) async {
    await _movieVOInsertionAdapter.insertList(
        movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertMovie(MovieVO movie) async {
    await _movieVOInsertionAdapter.insert(movie, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _collectionVOTypeConverter = CollectionVOTypeConverter();
final _genreListTypeConverter = GenreListTypeConverter();
final _genreIdListTypeConverter = GenreIdListTypeConverter();
final _productionCompanyListConverter = ProductionCompanyListConverter();
final _productionCountryListTypeConverter =
    ProductionCountryListTypeConverter();
final _spokenLanguageListConverter = SpokenLanguageListConverter();
