import 'dart:convert';

MovieResponse movieResponseFromJson(String str) =>
    MovieResponse.fromJson(json.decode(str));

String movieResponseToJson(MovieResponse data) => json.encode(data.toJson());

class MovieResponse {
  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  MovieResponse({this.page, this.results, this.totalPages, this.totalResults});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    results = json["results"] == null
        ? null
        : (json["results"] as List).map((e) => Movie.fromJson(e)).toList();
    totalPages = json["total_pages"];
    totalResults = json["total_results"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["page"] = page;
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    data["total_pages"] = totalPages;
    data["total_results"] = totalResults;
    return data;
  }
}

class Movie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    genreIds =
        json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"]);
    id = json["id"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    // voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }

  factory Movie.fromDb(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        backdropPath: json["backdrop_path"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
      );

  Map<String, dynamic> toDb() => {
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "backdrop_path": backdropPath,
        "poster_path": posterPath,
        "release_date": releaseDate,
      };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["adult"] = adult;
    data["backdrop_path"] = backdropPath;
    if (genreIds != null) {
      data["genre_ids"] = genreIds;
    }
    data["id"] = id;
    data["original_language"] = originalLanguage;
    data["original_title"] = originalTitle;
    data["overview"] = overview;
    data["popularity"] = popularity;
    data["poster_path"] = posterPath;
    data["release_date"] = releaseDate;
    data["title"] = title;
    data["video"] = video;
    data["vote_average"] = voteAverage;
    data["vote_count"] = voteCount;
    return data;
  }
}
