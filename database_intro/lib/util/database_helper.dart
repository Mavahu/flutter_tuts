import 'dart:async';
import 'dart:io';

import 'package:database_intro/models/user.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as ppath;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnUsername = "username";
  final String columnPasswod = "password";

  static sql.Database _db;

  Future<sql.Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory =
        await ppath.getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, "maindb.db");

    var ourDB = await sql.openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  /*
    id  | username  | password
    ------------------------
    1   | Martin    | martin
    2   | Peter     | peter
   */
  void _onCreate(sql.Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY,$columnUsername TEXT, $columnPasswod TEXT)");
  }

  //Insert User
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableUser", user.toMap());
    return res;
  }

  //Get Users
  Future<List> getAllUser() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return sql.Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("Select * FROM $tableUser WHERE $columnId = $id");
    if (result.length == 0) return null;
    return User.fromMap(result.first);
  }

  Future<String> deleteUser(int id) async {
    var dbClient = await db;

    int response = await dbClient
        .delete("$tableUser", where: "$columnId = ?", whereArgs: [id]);
    if (response == 1){
      return "User got deleted";
    }
    else{
      return "Something went wrong";
    }
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;

    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return await dbClient.close();
  }
}
