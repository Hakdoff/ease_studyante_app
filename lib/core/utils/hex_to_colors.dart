import 'package:flutter/material.dart';

Color hexToColors(String colorCode) {
  String color = colorCode.replaceAll('#', '0xff');

  return Color(int.parse(color));
}

extension HexColor on Color {
  String toHexTriplet() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toLowerCase()}';
}
