import 'dart:developer';
import 'dart:io';

import 'package:e_movie/config/util/constant.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbname = Constant.dbname;
  static final _dbversion = Constant.dbversion;
  static final tableMovie = Constant.movie;
  static final tableTvShow = Constant.tvShow;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbname);

    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    createDatabaseTable(db, version);
  }

  Future createDatabaseTable(Database db, int version) async {
    String movieTable = tableMovie;
    String tvShowTable = tableTvShow;

    await db.execute('''
          CREATE TABLE $movieTable(
            id INTEGER PRIMARY KEY,
            title TEXT,
            backdrop_path TEXT,
            poster_path TEXT,
            overview TEXT,
            original_title TEXT,
            release_date TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tvShowTable(
            id INTEGER PRIMARY KEY,
            name TEXT,
            backdrop_path TEXT,
            poster_path TEXT,
            overview TEXT,
            original_name TEXT,
            first_air_date TEXT
          )
          ''');
  }
}
