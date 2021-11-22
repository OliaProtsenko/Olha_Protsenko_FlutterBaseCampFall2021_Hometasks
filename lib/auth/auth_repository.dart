import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserModel.dart';

class AuthRepository {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/AuthDB.db';
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE User ("
          "id INTEGER PRIMARY KEY,"
          "username TEXT,"
          "password TEXT,"
          "email TEXT"
          ")");
    });
  }

  newUser(UserModel newUser) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into User (id,username,password,email)"
        " VALUES (?,?,?,?)",
        [id, newUser.username, newUser.password, newUser.email]);
    return raw;
  }

  getUser(String username, String password) async {
    final db = await database;
    print('start');
    var res = await db.rawQuery(
        "SELECT * FROM User WHERE username='${username}' AND password='${password}'");
    return res.isNotEmpty ? UserModel.fromJson(res.first) : Null;
  }

  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    final user = await getUser(username, password);

    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    return (user != null) ? user.userId : null;
  }

  Future<int> signUp({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    return await newUser(
        UserModel(username: username, email: email, password: password));
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
