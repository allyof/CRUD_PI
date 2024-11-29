import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:crud_projetoi_lista/database/script.dart';

class DatabaseConfig {
  static const String _dbName = "app_database,db";
  static const int _databaseVersion = 1;

  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    return _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _dbName);

    final db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return db;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(createTable);
    await db.execute(insertContatos);
  }
}
