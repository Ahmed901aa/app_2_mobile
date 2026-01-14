import 'dart:async';
import 'dart:ui';

class TimerController {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;
  Function(int)? onTick;
  VoidCallback? onComplete;

  bool get isRunning => _isRunning;
  int get remainingSeconds => _remainingSeconds;

  void start(int minutes) {
    if (_isRunning) {
      stop();
      return;
    }
    _remainingSeconds = minutes * 60;
    _isRunning = true;
    onTick?.call(_remainingSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        onTick?.call(_remainingSeconds);
      } else {
        stop();
        onComplete?.call();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _isRunning = false;
    _remainingSeconds = 0;
    onTick?.call(0);
  }

  void dispose() {
    _timer?.cancel();
  }

  static String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
