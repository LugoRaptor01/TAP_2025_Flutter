import 'dart:io';

import 'package:flutter_application_2/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {

  static const NAMEDB = 'USERDB';
  static const VERSIONDB = 1;

  static Database? _database;

  Future <Database?> get database async { //patrón singleton

    if (_database != null) return _database;

      return _database = await initDatabase();
  }

  Future <Database?> initDatabase() async {

    Directory folder = await getApplicationDocumentsDirectory();

    String path = join(folder.path, NAMEDB); // concatenacion para la ruta del archivo de la base de datos.

    return openDatabase(

      path,
      version: VERSIONDB,
      onCreate: (db, version) {

        String query = '''CREATE TABLE tblUsers(
          idUser INTEGER PRIMARY KEY,
          userName varchar(50),
          ássName varchar(32)
        )
        ''';

        db.execute(query);
      }
    );
  }

  Future<int> INSERT(Map<String, dynamic> data) async {

    final con = await database;

    return con!.insert('tblUsers', data);
    
  }

  Future<int> UPDATE(Map<String, dynamic> data) async {
    
    final con = await database;

    return con!.update('tblUsers', data, where: 'idUser=?', 
      whereArgs: [data['idUser']]
    ); //idUser = ? es una consulta parametrizada.

  }

  Future <int> DELETE (int idUser) async {

    final Database? con = await database;
    
    return con!.delete('tblUsers', where: 'idUsers = ?', whereArgs: [idUser]);

  }

  Future <List<UserModel>> SELECT () async {

    final con = await database;
    final res = await con!.query('tblUser');

    return res.map((user) => UserModel.fromMap(user)).toList();

  }
}