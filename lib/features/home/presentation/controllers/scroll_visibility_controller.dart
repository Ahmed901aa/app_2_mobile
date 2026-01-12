import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollVisibilityController {
  final ScrollController scrollController;
  final Function(bool) onVisibilityChanged;
  bool _isVisible = true;

  ScrollVisibilityController({
    required this.scrollController,
    required this.onVisibilityChanged,
  }) {
    _setupListener();
  }

  void _setupListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        // Scrolling down - hide
        if (_isVisible) {
          _isVisible = false;
          onVisibilityChanged(false);
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        // Scrolling up - show
        if (!_isVisible) {
          _isVisible = true;
          onVisibilityChanged(true);
        }
      }
    });
  }

  void dispose() {
    scrollController.dispose();
  }
}
