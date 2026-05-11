import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/traffic_sign.dart';
import '../data/services/signs_service.dart';

part 'traffic_signs_provider.g.dart';

@riverpod
SignsService signsService(Ref ref) {
  return SignsService();
}

@riverpod
Future<SignsData> signsData(Ref ref) async {
  final service = ref.watch(signsServiceProvider);
  return service.loadSignsData();
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String? build() => null;

  void select(String? category) {
    state = category;
  }
}
