// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mock_exam_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MockExamResult {

 String get id; int get score; int get totalQuestions; DateTime get timestamp; bool get isPassed;
/// Create a copy of MockExamResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MockExamResultCopyWith<MockExamResult> get copyWith => _$MockExamResultCopyWithImpl<MockExamResult>(this as MockExamResult, _$identity);

  /// Serializes this MockExamResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MockExamResult&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,score,totalQuestions,timestamp,isPassed);

@override
String toString() {
  return 'MockExamResult(id: $id, score: $score, totalQuestions: $totalQuestions, timestamp: $timestamp, isPassed: $isPassed)';
}


}

/// @nodoc
abstract mixin class $MockExamResultCopyWith<$Res>  {
  factory $MockExamResultCopyWith(MockExamResult value, $Res Function(MockExamResult) _then) = _$MockExamResultCopyWithImpl;
@useResult
$Res call({
 String id, int score, int totalQuestions, DateTime timestamp, bool isPassed
});




}
/// @nodoc
class _$MockExamResultCopyWithImpl<$Res>
    implements $MockExamResultCopyWith<$Res> {
  _$MockExamResultCopyWithImpl(this._self, this._then);

  final MockExamResult _self;
  final $Res Function(MockExamResult) _then;

/// Create a copy of MockExamResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? score = null,Object? totalQuestions = null,Object? timestamp = null,Object? isPassed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MockExamResult].
extension MockExamResultPatterns on MockExamResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MockExamResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MockExamResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MockExamResult value)  $default,){
final _that = this;
switch (_that) {
case _MockExamResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MockExamResult value)?  $default,){
final _that = this;
switch (_that) {
case _MockExamResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int score,  int totalQuestions,  DateTime timestamp,  bool isPassed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MockExamResult() when $default != null:
return $default(_that.id,_that.score,_that.totalQuestions,_that.timestamp,_that.isPassed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int score,  int totalQuestions,  DateTime timestamp,  bool isPassed)  $default,) {final _that = this;
switch (_that) {
case _MockExamResult():
return $default(_that.id,_that.score,_that.totalQuestions,_that.timestamp,_that.isPassed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int score,  int totalQuestions,  DateTime timestamp,  bool isPassed)?  $default,) {final _that = this;
switch (_that) {
case _MockExamResult() when $default != null:
return $default(_that.id,_that.score,_that.totalQuestions,_that.timestamp,_that.isPassed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MockExamResult implements MockExamResult {
  const _MockExamResult({required this.id, required this.score, required this.totalQuestions, required this.timestamp, required this.isPassed});
  factory _MockExamResult.fromJson(Map<String, dynamic> json) => _$MockExamResultFromJson(json);

@override final  String id;
@override final  int score;
@override final  int totalQuestions;
@override final  DateTime timestamp;
@override final  bool isPassed;

/// Create a copy of MockExamResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MockExamResultCopyWith<_MockExamResult> get copyWith => __$MockExamResultCopyWithImpl<_MockExamResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MockExamResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MockExamResult&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isPassed, isPassed) || other.isPassed == isPassed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,score,totalQuestions,timestamp,isPassed);

@override
String toString() {
  return 'MockExamResult(id: $id, score: $score, totalQuestions: $totalQuestions, timestamp: $timestamp, isPassed: $isPassed)';
}


}

/// @nodoc
abstract mixin class _$MockExamResultCopyWith<$Res> implements $MockExamResultCopyWith<$Res> {
  factory _$MockExamResultCopyWith(_MockExamResult value, $Res Function(_MockExamResult) _then) = __$MockExamResultCopyWithImpl;
@override @useResult
$Res call({
 String id, int score, int totalQuestions, DateTime timestamp, bool isPassed
});




}
/// @nodoc
class __$MockExamResultCopyWithImpl<$Res>
    implements _$MockExamResultCopyWith<$Res> {
  __$MockExamResultCopyWithImpl(this._self, this._then);

  final _MockExamResult _self;
  final $Res Function(_MockExamResult) _then;

/// Create a copy of MockExamResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? score = null,Object? totalQuestions = null,Object? timestamp = null,Object? isPassed = null,}) {
  return _then(_MockExamResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isPassed: null == isPassed ? _self.isPassed : isPassed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
