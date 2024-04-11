import 'package:ease_studyante_app/core/common_widget/custom_text.dart';
import 'package:ease_studyante_app/gen/assets.gen.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
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
            const CustomText(
              text: 'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
