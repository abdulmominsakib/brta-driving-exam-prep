import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import '../../../core/services/database_service.dart';

class PracticeState {
  final int unlockedIndex;
  final Set<String> completedSections;

  const PracticeState({
    this.unlockedIndex = 0,
    this.completedSections = const {},
  });

  PracticeState copyWith({int? unlockedIndex, Set<String>? completedSections}) {
    return PracticeState(
      unlockedIndex: unlockedIndex ?? this.unlockedIndex,
      completedSections: completedSections ?? this.completedSections,
    );
  }
}

class PracticeProgressNotifier extends Notifier<PracticeState> {
  static const _keyUnlocked = 'unlocked_level_index';
  static const _keyCompleted = 'completed_sections';
  final _store = StoreRef<String, dynamic>.main();

  @override
  PracticeState build() {
    _loadProgress();
    return const PracticeState();
  }

  Future<void> _loadProgress() async {
    final db = await DatabaseService().database;
    final savedIndex = await _store.record(_keyUnlocked).get(db) as int? ?? 0;
    final completedList =
        await _store.record(_keyCompleted).get(db) as List<dynamic>?;

    final completedSet = completedList?.map((e) => e.toString()).toSet() ?? {};

    state = PracticeState(
      unlockedIndex: savedIndex,
      completedSections: completedSet,
    );
  }

  Future<void> unlockNextLevel(int completedLevelIndex) async {
    if (completedLevelIndex >= state.unlockedIndex) {
      final nextLevel = state.unlockedIndex + 1;
      state = state.copyWith(unlockedIndex: nextLevel);

      final db = await DatabaseService().database;
      await _store.record(_keyUnlocked).put(db, nextLevel);
    }
  }

  Future<void> markSectionCompleted(String dataPath) async {
    if (!state.completedSections.contains(dataPath)) {
      final newSet = {...state.completedSections, dataPath};
      state = state.copyWith(completedSections: newSet);

      final db = await DatabaseService().database;
      await _store.record(_keyCompleted).put(db, newSet.toList());
    }
  }

  Future<void> resetProgress() async {
    state = const PracticeState();
    final db = await DatabaseService().database;
    await _store.record(_keyUnlocked).put(db, 0);
    await _store.record(_keyCompleted).put(db, []);
  }
}

final practiceProgressProvider =
    NotifierProvider<PracticeProgressNotifier, PracticeState>(
      () => PracticeProgressNotifier(),
    );
