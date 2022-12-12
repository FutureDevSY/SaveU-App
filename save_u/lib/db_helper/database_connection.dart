import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  /*DB Connection 반환*/
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'SaveU.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  /*DB 생성*/
  Future<void> _createDatabase(Database database, int version) async {
    /* Table 생성 쿼리 선언*/
    String sql_create_category =
        "CREATE TABLE category(id INTEGER PRIMARY KEY, name TEXT NOT NULL);";
    String sql_create_sub_category =
        "CREATE TABLE subCategory(id INTEGER PRIMARY KEY, name TEXT NOT NULL, categoryId INT NOT NULL);";
    String sql_create_safe_info =
        "CREATE TABLE safeInfo(id INTEGER PRIMARY KEY, title TEXT NOT NULL, content TEXT NOT NULL, scrap INTEGER NOT NULL, link TEXT, subCategoryId INTEGER NOT NULL);";

    /* Table 생성 */
    await database.execute(sql_create_category);
    await database.execute(sql_create_sub_category);
    await database.execute(sql_create_safe_info);

    /* data 가져오기 */
    final String response =
        await rootBundle.loadString('assets/categories.json');
    final data = await json.decode(response);
    var categories = data["items"];

    final String response2 =
        await rootBundle.loadString('assets/sub_categories.json');
    final data2 = await json.decode(response2);
    var subCategories = data2["items"];

    final String response3 =
        await rootBundle.loadString('assets/safe_infos.json');
    final data3 = await json.decode(response3);
    var safeInfos = data3["items"];

    /* data 삽입 */
    var batch = database.batch();
    for (int i = 0; i < categories.length; i++) {
      batch.insert('category', categories[i]);
    }
    for (int i = 0; i < subCategories.length; i++) {
      batch.insert('subCategory', subCategories[i]);
    }
    for (int i = 0; i < safeInfos.length; i++) {
      batch.insert('safeInfo', safeInfos[i]);
    }
    await batch.commit(noResult: true);
  }

  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
