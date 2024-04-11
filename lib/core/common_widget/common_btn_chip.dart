import 'package:flutter/material.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';

class CommonBtnChop extends StatelessWidget {
  const CommonBtnChop({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorName.secondary,
      ),
      child: CustomText(
        text: title,
        style: textTheme.labelLarge?.copyWith(
          color: ColorName.primary,
        ),
      ),
    );
  }
}
