// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBProvider {
  @protected
  static Future<Database> openDB() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'EmployeeControl'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
            CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            name VARCHAR, lastname VARCHAR, phone VARCHAR, address VARCHAR, 
            area VARCHAR, workplace VARCHAR,photopath VARCHAR,age INTEGER)

            CREATE TABLE records(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            userId INTEGER NOT NULL, typeRecord INTEGER, createdAt DATETIME,
            FOREIGN KEY (id) REFERENCES users(id))
            ''');
      },
    );
  }
}
