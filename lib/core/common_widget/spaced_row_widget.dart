// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:ease_studyante_app/core/common_widget/spaced_linear_widget.dart';
import 'package:flutter/material.dart';

/// A custom widget similar to [Row], but allows
/// setting the [spacing] between each [children].
class SpacedRow extends SpacedLinearLayout {
  const SpacedRow({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,
    super.spacing,
  });

  @override
  final Axis axis = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      // ignore: avoid-returning-widgets
      children: getChildren(),
    );
  }
}
