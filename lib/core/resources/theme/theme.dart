// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ease_studyante_app/core/resources/theme/app_theme.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';

abstract class ColorSchemes {
  static const Color seed = Color(0xFF0E0A08);
  static const Color red = Color(0xFFE72531);
  static const Color bodyLabel = Color(0xFF494E56);

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: seed,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE2DFFF),
    onPrimaryContainer: Color(0xFF0A006B),
    secondary: Color(0xFF7E7DDE),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE2E0F9),
    onSecondaryContainer: Color(0xFF1A1A2C),
    tertiary: Color(0xFF795369),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD8EB),
    onTertiaryContainer: Color(0xFF2F1124),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF1C1B1F),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1C1B1F),
    surfaceVariant: Color(0xFFE4E1EC),
    onSurfaceVariant: Color(0xFF47464F),
    outline: Color(0xFFBCBCBC),
    onInverseSurface: Color(0xFFF3EFF4),
    inverseSurface: Color(0xFF313034),
    inversePrimary: Color(0xFFC1C1FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4C4BD4),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: seed,
    onPrimary: Color(0xFF1600A8),
    primaryContainer: Color(0xFF322EBC),
    onPrimaryContainer: Color(0xFFE2DFFF),
    secondary: Color(0xFF006466),
    onSecondary: Color(0xFF2F2F42),
    secondaryContainer: Color(0xFF454559),
    onSecondaryContainer: Color(0xFFE2E0F9),
    tertiary: Color(0xFFE9B9D3),
    onTertiary: Color(0xFF46263A),
    tertiaryContainer: Color(0xFF5F3C51),
    onTertiaryContainer: Color(0xFFFFD8EB),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: seed,
    onBackground: Color(0xFFE5E1E6),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFF4D194D),
    surfaceVariant: Color(0xFF47464F),
    onSurfaceVariant: Color(0xFFC8C5D0),
    outline: Color(0xFF918F9A),
    onInverseSurface: Color(0xFF1C1B1F),
    inverseSurface: Color(0xFFE5E1E6),
    inversePrimary: Color(0xFF4C4BD4),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFC1C1FF),
  );
}

abstract class AppThemes {
  static AppThemeData get lightTheme =>
      _baseTheme(ColorSchemes.light).copyWith(brightness: Brightness.light);

  static AppThemeData get darkTheme =>
      _baseTheme(ColorSchemes.dark).copyWith(brightness: Brightness.dark);

  static AppThemeData _baseTheme(ColorScheme colorScheme) {
    return AppThemeData(
      brightness: colorScheme.brightness,
      edgeInsets: const EdgeInsetsData(
        containerPadding: EdgeInsets.all(24),
      ),
      rawDimensions: RawDimensionsData(
        cornerRadius: 12,
        maxWidth: 512,
        textFieldSpacing: 24,
      ),
      textStyles: TextStylesData(
        actionsStyle: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

abstract class MaterialAppThemes {
  static ThemeData get lightTheme =>
      _createBaseTheme(AppThemes.lightTheme, ColorSchemes.light);

  static ThemeData get darkTheme =>
      _createBaseTheme(AppThemes.darkTheme, ColorSchemes.dark);

  static ThemeData _createBaseTheme(
      AppThemeData base, ColorScheme colorScheme) {
    return ThemeData(
      extensions: [base],
      primaryColor: colorScheme.primary,
      brightness: base.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        color: colorScheme.background,
        elevation: 1,
        foregroundColor: colorScheme.onBackground,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        actionsIconTheme: IconThemeData(color: colorScheme.primary),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
          fontSize: 20,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(base.rawDimensions.cornerRadius)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      visualDensity: VisualDensity.standard,
      fontFamily: 'JosefinSans',
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(base.rawDimensions.cornerRadius)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: ColorName.primary,
          ),
        ),
        hintStyle: TextStyle(
          color: colorScheme.outline.withOpacity(0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: ColorName.primary,
          ),
        ),
        iconColor: colorScheme.outline.withOpacity(0.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          elevation: 8,
          minimumSize: const Size(134, 54),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'JosefinSans',
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(base.rawDimensions.cornerRadius)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(134, 64),
          foregroundColor: colorScheme.onBackground,
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'JosefinSans',
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(base.rawDimensions.cornerRadius)),
          ),
          side: BorderSide(color: colorScheme.onBackground),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(
            fontSize: 18,
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(base.rawDimensions.cornerRadius)),
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 57,
          height: 1.1,
          letterSpacing: -0.25,
        ),
        displayMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 40,
          height: 1.1,
          letterSpacing: 0,
        ),
        displaySmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 36,
          height: 1.1,
          letterSpacing: 0,
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          height: 1.1,
          letterSpacing: 0,
          color: colorScheme.onBackground,
        ),
        headlineMedium: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          height: 1.1,
          letterSpacing: 0,
        ),
        headlineSmall: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          height: 1.1,
          letterSpacing: 0,
        ),
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 22,
          height: 1.1,
          letterSpacing: 0,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.1,
          letterSpacing: 0.1,
        ),
        titleSmall: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.1,
          letterSpacing: 0.1,
        ),
        labelLarge: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 1.8,
          letterSpacing: 0.1,
        ),
        labelMedium: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        labelSmall: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        bodyLarge: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.5,
          letterSpacing: 0.25,
        ),
        bodySmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.1,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
