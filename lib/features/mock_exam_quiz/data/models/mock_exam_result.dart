import 'package:freezed_annotation/freezed_annotation.dart';

part 'mock_exam_result.g.dart';
part 'mock_exam_result.freezed.dart';

@freezed
abstract class MockExamResult with _$MockExamResult {
  const factory MockExamResult({
    required String id,
    required int score,
    required int totalQuestions,
    required DateTime timestamp,
    required bool isPassed,
  }) = _MockExamResult;

  factory MockExamResult.fromJson(Map<String, dynamic> json) =>
      _$MockExamResultFromJson(json);
}
