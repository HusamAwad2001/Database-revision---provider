import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider _instance = DbProvider._internal();
  late Database _database;

  factory DbProvider() {
    return _instance;
  }

  DbProvider._internal();

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db){},
      onCreate: (Database db, int version) async{
        await db.execute('CREATE TABLE users('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT,'
            'email TEXT,'
            'password TEXT'
            ')');
        await db.execute('CREATE TABLE notes ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT,'
            'status BOOLEAN,'
            'user_id INTEGER,'
            'date DATETIME'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion){},
      onDowngrade: (Database db, int oldVersion, int newVersion){}
    );
  }
}
