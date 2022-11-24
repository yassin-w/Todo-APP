// ignore_for_file: camel_case_types, unused_element, avoid_print, prefer_conditional_assignment, depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDB();
      return _db;
    } else {
      return _db;
    }
  }

  _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "todos.db");

    Database mydb = await openDatabase(path,
        version: 1, onCreate: _createDB, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("called  _onUpgrade  ************************ ");
  }

  _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "todo"(
    id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
     name TEXT NOT NULL,
     status TEXT 
    )

   ''');
    print("CREATE DATABASE AND TABLES ************************ ");
  }

  /// select data from todo table  */

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> respose = await mydb!.rawQuery(sql);

    return respose;
  }

  /// add data from todo table  */

  insertData(String sql) async {
    Database? mydb = await db;
    int respose = await mydb!.rawInsert(sql);
    return respose;
  }

  /// update data from todo table  */

  updateData(String sql) async {
    Database? mydb = await db;
    int respose = await mydb!.rawUpdate(sql);
    return respose;
  }

  /// delete data from todo table  */

  deleteData(String sql) async {
    Database? mydb = await db;
    int respose = await mydb!.rawDelete(sql);
    return respose;
  }

  deleteOptionTable() async {
    final mydb = await db;
    mydb!.query("DROP TABLE IF EXISTS todo");
    _createDB(mydb, 1);
  }
}
