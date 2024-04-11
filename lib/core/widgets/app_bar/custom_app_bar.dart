import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  required BuildContext context,
  required String title,
}) {
  final themeContext = Theme.of(context);

  return AppBar(
    title: Text(
      title,
      style: themeContext.textTheme.titleMedium,
    ),
  );
}
