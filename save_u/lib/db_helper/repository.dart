import '../db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

//DB에 직접적인 CRUD 수행
class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  readDataByColumn(table, columnName, columnContent) async {
    var connection = await database;
    return await connection
        ?.query(table, where: '$columnName=?', whereArgs: [columnContent]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  updateColumn(table, id, columnName, columnContent) async {
    var connection = await database;
    return await connection?.rawUpdate(
        'UPDATE $table SET $columnName = $columnContent WHERE id = $id');
  }

  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
