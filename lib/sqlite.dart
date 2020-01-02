//import 'package:sqflite/sqflite.dart';
//
//class SqlHelper{
//
//  static final BD _instance = new BD.internal();
//
//  createDatabase() async {
//    String databasesPath = await getDatabasesPath();
//    String dbPath = join(databasesPath, 'my.db');
//
//    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
//    return database;
//  }
//
//}