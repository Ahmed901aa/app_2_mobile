import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/font_manager.dart';
import 'package:app_2_mobile/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData getLightAppTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColorManager.background,
      primaryColor: ColorManager.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primary,
        surface: ColorManager.white,
        onSurface: ColorManager.text,
        background: ColorManager.background,
        onBackground: ColorManager.text,
        error: ColorManager.error,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorManager.black),
        titleTextStyle: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorManager.inputBackground,
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        hintStyle: getRegularStyle(color: ColorManager.textSecondary),
        labelStyle: getMediumStyle(color: ColorManager.textSecondary),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.inputBorder, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.inputFocused, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          textStyle: getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorManager.white,
        shadowColor: Colors.black.withOpacity(0.08),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData getDarkAppTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColorManager.darkBackground,
      primaryColor: ColorManager.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primary,
        surface: ColorManager.darkSurface,
        onSurface: ColorManager.darkText,
        background: ColorManager.darkBackground,
        onBackground: ColorManager.darkText,
        error: ColorManager.error,
        brightness: Brightness.dark,
        surfaceVariant: ColorManager.darkSurfaceVariant,
        onSurfaceVariant: ColorManager.darkTextSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.darkSurface,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorManager.darkText),
        titleTextStyle: getBoldStyle(color: ColorManager.darkText, fontSize: FontSize.s18),
        shadowColor: ColorManager.darkCardShadow.withOpacity(0.3),
      ),
      textTheme: TextTheme(
        displayLarge: getBoldStyle(color: ColorManager.darkText, fontSize: FontSize.s22),
        bodyLarge: getRegularStyle(color: ColorManager.darkText),
        bodyMedium: getRegularStyle(color: ColorManager.darkText),
        titleMedium: getMediumStyle(color: ColorManager.darkText),
        titleSmall: getMediumStyle(color: ColorManager.darkTextSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorManager.darkInputBackground,
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        hintStyle: getRegularStyle(color: ColorManager.darkTextSecondary),
        labelStyle: getMediumStyle(color: ColorManager.darkTextSecondary),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.darkInputBorder, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          textStyle: getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          shadowColor: ColorManager.primary.withOpacity(0.3),
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorManager.darkSurface,
        shadowColor: ColorManager.darkCardShadow.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerColor: ColorManager.darkDivider,
      iconTheme: IconThemeData(
        color: ColorManager.darkText,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.darkSurface,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.darkTextSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
