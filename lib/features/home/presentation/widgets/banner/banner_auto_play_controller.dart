import 'dart:async';
import 'package:flutter/material.dart';

class BannerAutoPlayController {
  Timer? _timer;
  final VoidCallback onNext;
  final int itemCount;

  BannerAutoPlayController({
    required this.onNext,
    required this.itemCount,
  });

  void start() {
    if (itemCount <= 1) return;
    
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      onNext();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
  }
}
