import 'dart:async';
import 'package:flutter/material.dart';

class TimerController extends ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isTimerRunning = false;

  int get remainingSeconds => _remainingSeconds;
  bool get isTimerRunning => _isTimerRunning;

  void startTimer(int minutes) {
    if (_isTimerRunning) {
      stopTimer();
      return;
    }

    _remainingSeconds = minutes * 60;
    _isTimerRunning = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    _remainingSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
