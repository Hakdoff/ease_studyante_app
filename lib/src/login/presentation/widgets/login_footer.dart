import 'package:flutter/material.dart';

import '../../../../core/common_widget/common_widget.dart';
import '../../../../gen/colors.gen.dart';
import '../../../forgot_password/forgot_password_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: CustomTextLink(
        style: const TextStyle(
          color: ColorName.placeHolder,
        ),
        text: "Forgot Password?",
        onTap: () {
          Navigator.of(context).pushNamed(
            ForgotPasswordPage.routeName,
          );
        },
      ),
    );
  }
}
