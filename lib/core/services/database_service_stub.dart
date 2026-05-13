import 'package:sembast_web/sembast_web.dart';

class DatabaseService {
  static final DatabaseService _singleton = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await databaseFactoryWeb.openDatabase('driving_shikkha.db');
  }
}
