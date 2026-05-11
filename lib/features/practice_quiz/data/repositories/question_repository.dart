import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sembast/sembast.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/models/quiz_model.dart';

class QuestionRepository {
  static const String _storeName = 'questions';
  final _store = intMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DatabaseService().database;

  Future<void> seedQuestionsIfNeeded() async {
    final db = await _db;
    final count = await _store.count(db);
    if (count > 0) return; // Already seeded

    final files = [
      'assets/data/questions/categorized/basics.json',
      'assets/data/questions/categorized/mechanisms.json',
      'assets/data/questions/categorized/penalties.json',
      'assets/data/questions/categorized/road_signs.json',
      'assets/data/questions/categorized/traffic_rules.json',
    ];

    for (final file in files) {
      try {
        final jsonString = await rootBundle.loadString(file);
        final data = json.decode(jsonString) as Map<String, dynamic>;
        final category = data['category'] as String;
        final questions = data['questions'] as List;

        for (final q in questions) {
          final questionMap = Map<String, dynamic>.from(q as Map);
          questionMap['category'] = category;
          // Also save the original file path to help with progress tracking if needed
          questionMap['source_path'] = file;
          await _store.add(db, questionMap);
        }
      } catch (e) {
        debugPrint('Error seeding questions from $file: $e');
      }
    }
  }

  Future<List<Question>> getQuestionsByCategory(String category) async {
    final db = await _db;
    final finder = Finder(filter: Filter.equals('category', category));
    final snapshots = await _store.find(db, finder: finder);
    return snapshots.map((s) => Question.fromJson(s.value)).toList();
  }

  Future<List<Question>> getQuestionsBySourcePath(String path) async {
    final db = await _db;
    final finder = Finder(filter: Filter.equals('source_path', path));
    final snapshots = await _store.find(db, finder: finder);
    return snapshots.map((s) => Question.fromJson(s.value)).toList();
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await _db;
    final snapshots = await _store.find(db);
    return snapshots.map((s) => Question.fromJson(s.value)).toList();
  }
}
