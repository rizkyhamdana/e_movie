import 'package:e_movie/config/helper/database_helper.dart';
import 'package:e_movie/data/model/movie.dart';
import 'package:e_movie/data/model/tv_show.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await DatabaseHelper.instance.database;
    return _database;
  }

  Future<int> insertMovie(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(
      DatabaseHelper.tableMovie,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteMovie(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(DatabaseHelper.tableMovie, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Movie>> queryAllMovie() async {
    var result = <Movie>[];
    Database? db = await instance.database;
    var list = await db!.query(DatabaseHelper.tableMovie);
    for (var v in list) {
      result.add(Movie.fromDb(v));
    }
    return result;
  }

  Future<List<Movie>> queryMovieById(int id) async {
    var result = <Movie>[];
    Database? db = await instance.database;
    var list = await db!
        .query(DatabaseHelper.tableMovie, where: 'id = ?', whereArgs: [id]);
    for (var v in list) {
      result.add(Movie.fromDb(v));
    }
    return result;
  }

  Future<int> insertTvShow(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(
      DatabaseHelper.tableTvShow,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteTvShow(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(DatabaseHelper.tableTvShow, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TvShow>> queryAllTvShow() async {
    var result = <TvShow>[];
    Database? db = await instance.database;
    var list = await db!.query(DatabaseHelper.tableTvShow);
    for (var v in list) {
      result.add(TvShow.fromDb(v));
    }
    return result;
  }

  Future<List<TvShow>> queryTvShowById(int id) async {
    var result = <TvShow>[];
    Database? db = await instance.database;
    var list = await db!
        .query(DatabaseHelper.tableTvShow, where: 'id = ?', whereArgs: [id]);
    for (var v in list) {
      result.add(TvShow.fromDb(v));
    }
    return result;
  }
}
