import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/question_repository.dart';

final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepository();
});
