import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  static AudioService get instance => _instance;

  AudioPlayer? _player;

  AudioService._internal();

  /// Plays a timer click sound effect
  Future<void> playTimerClick() async {
    try {
      _player ??= AudioPlayer();
      await _player!.play(AssetSource('sounds/timer_click.mp3'));
    } catch (e) {
      print('Audio playback failed: $e');
    }
  }

  /// Dispose of audio resources
  void dispose() {
    _player?.dispose();
  }
}
