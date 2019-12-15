import 'dart:async';
import 'dart:io';

import 'package:no_to_do/models/nodoitem_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as ppath;

class DatabaseClient {
  static final DatabaseClient _instance = DatabaseClient.internal();

  factory DatabaseClient() => _instance;

  final String tableItem = "nodoTbl";
  final String columnId = "id";
  final String columnItemName = "itemName";
  final String columnDateCreated = "dateCreated";

  static sql.Database _db;

  Future<sql.Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseClient.internal();

  initDb() async {
    Directory documentDirectory =
        await ppath.getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, "notodo_db.db");

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
        "CREATE TABLE $tableItem($columnId INTEGER PRIMARY KEY,$columnItemName TEXT, $columnDateCreated TEXT)");
  }

  //Insert User
  Future<int> saveItem(NoDoItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableItem", item.toMap());
    return res;
  }

  //Get Users
  Future<List> getAllItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableItem ORDER BY $columnItemName DESC");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return sql.Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableItem"));
  }

  Future<NoDoItem> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("Select * FROM $tableItem WHERE $columnId = $id");
    if (result.length == 0) return null;
    return NoDoItem.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete("$tableItem", where: "$columnId = ?", whereArgs: [id]);
    /*if (response == 1){
      return "Item got deleted";
    }
    else{
      return "Something went wrong";
    }*/
  }

  Future<int> updateItem(NoDoItem item) async {
    var dbClient = await db;

    return await dbClient.update(tableItem, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return await dbClient.close();
  }
}
