import 'package:driving_shikkha/features/mock_exam_quiz/data/repositories/mock_exam_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockExamRepositoryProvider = Provider<MockExamRepository>((ref) {
  return MockExamRepository();
});
