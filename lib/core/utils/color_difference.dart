import 'package:flutter/material.dart';
import 'dart:math' as math;

double similarValue({required Color baseColor, required Color fromImageColor}) {
  final result = math.sqrt(math.pow((baseColor.red - fromImageColor.red), 2) +
      math.pow((baseColor.green - fromImageColor.green), 2) +
      math.pow((baseColor.blue - fromImageColor.blue), 2));

  return result;
}
