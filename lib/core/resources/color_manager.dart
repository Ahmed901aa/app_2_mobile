import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = const Color.fromARGB(255, 251, 83, 80);//0xFFE53935
  static Color primaryDark = const Color(0xFFC62828);//0xFFC62828
  static Color background = const Color(0xFFFAFAFA);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color grey = const Color(0xFF9E9E9E);
  static Color lightGrey = const Color(0xFFE0E0E0);
  static Color darkGrey = const Color(0xFF616161);
  static Color text = const Color(0xFF212121);
  static Color textSecondary = const Color(0xFF757575);
  static Color starRate = const Color(0xFFFFC107);
  static Color transparent = Colors.transparent;
  static Color error = const Color(0xFFD32F2F);
  static Color success = const Color(0xFF43A047);
  
  // Enhanced auth UI colors
  static Color accent = const Color.fromARGB(255, 0, 0, 0); // Pink/coral for primary buttons
  static Color accentLight = const Color(0xFFFFE5EE); // Light pink background
  static Color accentDark = const Color.fromARGB(255, 233, 30, 30); // Darker pink for hover/press
  
  // Input field colors
  static Color inputBackground = const Color(0xFFF5F5F5); // Light grey for inputs
  static Color inputBorder = const Color(0xFFE0E0E0); // Border color
  static Color inputFocused = const Color.fromARGB(255, 246, 70, 70); // Focused border (accent)
}
