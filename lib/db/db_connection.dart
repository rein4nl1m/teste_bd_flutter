import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "CheckCompra.db";
  static final _databaseVersion = 1;

  static final tableItem = "item";

  static final columnId = "_id";
  static final columnName = "name";
  static final columnAmount = "amount";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableItem (
          $columnId INTEGER PRIMARY KEY,
          $columnName TEXT NOT NULL,
          $columnAmount INTEGER NOT NULL)
        ''');
  }

  Future<int> insertItem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableItem, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsItem() async {
    Database db = await instance.database;
    return await db.query(tableItem);
  }

  Future<int> queryRowCountItem() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableItem'));
  }

  Future<int> updateItem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(tableItem, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await instance.database;
    return db.delete(tableItem, where: '$columnId = ?', whereArgs: [id]);
  }
}