import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  static const _soundKey = 'settings_sound_enabled';
  static const _hapticKey = 'settings_haptic_enabled';

  @override
  Future<SettingsState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final isSoundEnabled = prefs.getBool(_soundKey) ?? true; // Default true
    final isHapticEnabled = prefs.getBool(_hapticKey) ?? true; // Default true

    return SettingsState(
      isSoundEnabled: isSoundEnabled,
      isHapticEnabled: isHapticEnabled,
    );
  }

  Future<void> setSoundEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundKey, enabled);
    state = AsyncData(state.value!.copyWith(isSoundEnabled: enabled));
  }

  Future<void> setHapticEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hapticKey, enabled);
    state = AsyncData(state.value!.copyWith(isHapticEnabled: enabled));
  }
}

class SettingsState {
  final bool isSoundEnabled;
  final bool isHapticEnabled;

  SettingsState({required this.isSoundEnabled, required this.isHapticEnabled});

  SettingsState copyWith({bool? isSoundEnabled, bool? isHapticEnabled}) {
    return SettingsState(
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isHapticEnabled: isHapticEnabled ?? this.isHapticEnabled,
    );
  }
}
