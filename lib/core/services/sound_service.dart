import 'package:flutter_soloud/flutter_soloud.dart';
import 'dart:async';

class SoundService {
  static final SoLoud _soLoud = SoLoud.instance;

  // AudioSource objects to keep in memory for instant playback
  static AudioSource? _clickSource;
  static AudioSource? _successSource;
  static AudioSource? _errorSource;
  static AudioSource? _birdChirpSource;
  static AudioSource? _loadingSource;

  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;

    try {
      await _soLoud.init();

      // Load assets into memory (Asset paths must be full paths for SoLoud)
      _clickSource = await _soLoud.loadAsset('assets/sounds/click.mp3');
      _successSource = await _soLoud.loadAsset('assets/sounds/success.mp3');
      _errorSource = await _soLoud.loadAsset('assets/sounds/error.mp3');
      _birdChirpSource = await _soLoud.loadAsset(
        'assets/sounds/bird_chirp.mp3',
      );
      _loadingSource = await _soLoud.loadAsset('assets/sounds/loading.mp3');

      _isInitialized = true;
    } catch (e) {
      // print('Error initializing SoLoud: $e');
    }
  }

  static void playClick() => _play(_clickSource);
  static void playSuccess() => _play(_successSource);
  static void playError() => _play(_errorSource);
  static void playBirdChirp() => _play(_birdChirpSource);
  static void playLoading() => _play(_loadingSource);

  static void _play(AudioSource? source) {
    if (source != null && _isInitialized) {
      _soLoud.play(source);
    }
  }

  static Future<void> dispose() async {
    if (_isInitialized) {
      _soLoud.deinit();
      _isInitialized = false;
    }
  }
}
