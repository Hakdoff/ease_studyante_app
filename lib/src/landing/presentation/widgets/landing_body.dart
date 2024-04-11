import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/src/login/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBtn(
              label: 'Login as Teacher',
              onTap: () => handleOnTapTeacher(context),
            ),
            const Gap(30),
            CustomBtn(
              label: 'Login as Parent/Student',
              onTap: () => handleOnTapParentStudent(context),
            ),
          ],
        ),
      ),
    );
  }

  void handleOnTapTeacher(BuildContext context) {
    Navigator.of(context).pushNamed(
      LoginPage.routeName,
      arguments: LoginArgs(
        isTeacher: true,
        isStudent: false,
      ),
    );
  }

  void handleOnTapParentStudent(BuildContext context) {
    Navigator.of(context).pushNamed(LoginPage.routeName,
        arguments: LoginArgs(
          isTeacher: false,
          isStudent: true,
        ));
  }
}
