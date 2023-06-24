import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String dbName = 'favorites.db';
  static const String tableName = 'favorites';

  static Future<Database> initializeDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, dbName);

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE $tableName(id TEXT PRIMARY KEY)',
      );
    });
  }

  static Future<void> insertFavorite(String wallpaperId) async {
    final Database database = await initializeDatabase();
    await database.insert(tableName, {'id': wallpaperId},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteFavorite(String wallpaperId) async {
    final Database database = await initializeDatabase();
    await database.delete(tableName, where: 'id = ?', whereArgs: [wallpaperId]);
  }

  static Future<List<String>> getFavorites() async {
    final Database database = await initializeDatabase();
    final List<Map<String, dynamic>> results = await database.query(tableName);

    return results.map<String>((result) => result['id'] as String).toList();
  }

  static Future<List<String>> fetchFavorites() async {
    final Database database = await initializeDatabase();
    final List<Map<String, dynamic>> results = await database.query(tableName);
    return results.map<String>((result) => result['id'] as String).toList();
  }
}
