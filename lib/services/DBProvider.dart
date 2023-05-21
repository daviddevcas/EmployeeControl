// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBProvider {
  static const String users = '''
            CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            name VARCHAR, lastname VARCHAR, phone VARCHAR, address VARCHAR, 
            area VARCHAR, workplace VARCHAR,photopath VARCHAR,age INTEGER)
            ''';
  static const String records = '''
            CREATE TABLE records(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            userId INTEGER NOT NULL, typeRecord INTEGER, createdAt VARCHAR)
            ''';
  @protected
  static Future<Database> openDB() async {
    //databaseFactory.deleteDatabase(p.join(await getDatabasesPath(), 'EmployeeControl'));
    return openDatabase(
      p.join(await getDatabasesPath(), 'EmployeeControl'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(users);
        await db.execute(records);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1 && newVersion == 2) {}
      },
    );
  }
}
