import 'dart:convert';

TvShowResponse tvShowResponseFromJson(String str) =>
    TvShowResponse.fromJson(json.decode(str));

String tvShowResponseToJson(TvShowResponse data) => json.encode(data.toJson());

class TvShowResponse {
  int? page;
  List<TvShow>? results;
  int? totalPages;
  int? totalResults;

  TvShowResponse({this.page, this.results, this.totalPages, this.totalResults});

  TvShowResponse.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    results = json["results"] == null
        ? null
        : (json["results"] as List).map((e) => TvShow.fromJson(e)).toList();
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

class TvShow {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  TvShow(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  TvShow.fromJson(Map<String, dynamic> json) {
    backdropPath = json["backdrop_path"];
    firstAirDate = json["first_air_date"];
    genreIds =
        json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"]);
    id = json["id"];
    name = json["name"];
    originCountry = json["origin_country"] == null
        ? null
        : List<String>.from(json["origin_country"]);
    originalLanguage = json["original_language"];
    originalName = json["original_name"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    // voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }

  factory TvShow.fromDb(Map<String, dynamic> json) => TvShow(
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        backdropPath: json["backdrop_path"],
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
      );

  Map<String, dynamic> toDb() => {
        "id": id,
        "name": name,
        "original_name": originalName,
        "backdrop_path": backdropPath,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
      };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["backdrop_path"] = backdropPath;
    data["first_air_date"] = firstAirDate;
    if (genreIds != null) {
      data["genre_ids"] = genreIds;
    }
    data["id"] = id;
    data["name"] = name;
    if (originCountry != null) {
      data["origin_country"] = originCountry;
    }
    data["original_language"] = originalLanguage;
    data["original_name"] = originalName;
    data["overview"] = overview;
    data["popularity"] = popularity;
    data["poster_path"] = posterPath;
    data["vote_average"] = voteAverage;
    data["vote_count"] = voteCount;
    return data;
  }
}
