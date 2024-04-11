// coverage:ignore-file

import 'package:flutter/material.dart';

class AppThemeData extends ThemeExtension<AppThemeData> {
  const AppThemeData({
    required this.brightness,
    required this.edgeInsets,
    required this.rawDimensions,
    required this.textStyles,
  });

  final Brightness brightness;
  final EdgeInsetsData edgeInsets;
  final RawDimensionsData rawDimensions;
  final TextStylesData textStyles;

  @override
  AppThemeData copyWith({
    Brightness? brightness,
    EdgeInsetsData? edgeInsets,
    RawDimensionsData? rawDimensions,
    TextStylesData? textStyles,
    AppBarTheme? flatAppBarTheme,
  }) {
    return AppThemeData(
      brightness: brightness ?? this.brightness,
      edgeInsets: edgeInsets ?? this.edgeInsets,
      rawDimensions: rawDimensions ?? this.rawDimensions,
      textStyles: textStyles ?? this.textStyles,
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(
      ThemeExtension<AppThemeData>? other, double t) {
    return this;
  }
}

class EdgeInsetsData {
  const EdgeInsetsData({required this.containerPadding});

  final EdgeInsets containerPadding;
}

class RawDimensionsData {
  RawDimensionsData(
      {required this.maxWidth,
      required this.cornerRadius,
      required this.textFieldSpacing});

  final double maxWidth;
  final double cornerRadius;
  final double textFieldSpacing;
}

class TextStylesData {
  TextStylesData({required this.actionsStyle});

  final TextStyle actionsStyle;
}
