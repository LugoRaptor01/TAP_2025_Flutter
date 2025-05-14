import 'package:sqflite/sqflite.dart';

class UserDatabase {

  static const NAMEDB = 'USERDB';
  static const VERSIONDB = 1;

  static Database? _database;

  get database { //patrón singleton

    if (_database != null) return _database;

      return _database = initDatabase();
  }

  Database? initDatabase() {

    
  }
}