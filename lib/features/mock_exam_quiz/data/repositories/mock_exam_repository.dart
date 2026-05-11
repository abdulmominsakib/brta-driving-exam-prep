import 'package:sembast/sembast.dart';
import '../../../../core/services/database_service.dart';
import '../models/mock_exam_result.dart';

class MockExamRepository {
  static const String _storeName = 'mock_exam_results';
  final _store = intMapStoreFactory.store(_storeName);

  Future<Database> get _db async => await DatabaseService().database;

  Future<void> saveResult(MockExamResult result) async {
    final db = await _db;

    // Add new result
    await _store.add(db, result.toJson());

    // Enforce 15 items limit: Keep newest 15
    final count = await _store.count(db);
    if (count > 15) {
      final finder = Finder(
        sortOrders: [SortOrder('timestamp', true)], // Oldest first
        limit: count - 15,
      );
      final keysToDelete = await _store.findKeys(db, finder: finder);
      await _store.records(keysToDelete).delete(db);
    }
  }

  Future<List<MockExamResult>> getResults() async {
    final db = await _db;
    final finder = Finder(
      sortOrders: [SortOrder('timestamp', false)], // Newest first
    );

    final snapshots = await _store.find(db, finder: finder);
    return snapshots.map((snapshot) {
      return MockExamResult.fromJson(Map<String, dynamic>.from(snapshot.value));
    }).toList();
  }
}
