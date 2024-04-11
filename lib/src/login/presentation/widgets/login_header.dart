import 'package:flutter/material.dart';

import 'package:ease_studyante_app/core/common_widget/custom_text.dart';
import 'package:ease_studyante_app/gen/assets.gen.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: ColorName.primary,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(950, 300),
          bottomLeft: Radius.elliptical(950, 300),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Assets.appIcon.icLauncher.image(
            width: 180,
            height: 180,
          ),
          CustomText(
            text: title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
