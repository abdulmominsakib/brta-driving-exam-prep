// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_exam_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MockExamResult _$MockExamResultFromJson(Map<String, dynamic> json) =>
    _MockExamResult(
      id: json['id'] as String,
      score: (json['score'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isPassed: json['isPassed'] as bool,
    );

Map<String, dynamic> _$MockExamResultToJson(_MockExamResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'totalQuestions': instance.totalQuestions,
      'timestamp': instance.timestamp.toIso8601String(),
      'isPassed': instance.isPassed,
    };
