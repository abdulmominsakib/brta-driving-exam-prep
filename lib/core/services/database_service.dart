import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

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
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'driving_shikkha.db');

    try {
      return await databaseFactoryIo.openDatabase(dbPath);
    } catch (e) {
      // Handle "Invalid codec signature" (code 2) or other corruption by deleting the DB
      // This is safe here because QuestionRepository re-seeds data if empty
      bool shouldDelete = false;
      if (e is DatabaseException && e.code == 2) {
        shouldDelete = true;
      } else if (e.toString().contains('Invalid codec signature')) {
        shouldDelete = true;
      }

      if (shouldDelete) {
        final file = File(dbPath);
        if (await file.exists()) {
          await file.delete();
        }
        return await databaseFactoryIo.openDatabase(dbPath);
      }
      rethrow;
    }
  }
}
