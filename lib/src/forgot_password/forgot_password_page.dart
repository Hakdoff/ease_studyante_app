import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/common_widget/common_widget.dart';
import '../../core/common_widget/custom_appbar.dart';
import '../../gen/colors.gen.dart';
import '../login/presentation/widgets/login_header.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const String routeName = '/account/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Forgot Password"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginHeader(
              title: '',
            ),
            const Gap(50),
            Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomTextField(
                        textController: emailController,
                        labelText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        padding: EdgeInsets.zero,
                        parametersValidate: 'required',
                        validators: (value) {
                          if (value != null && EmailValidator.validate(value)) {
                            return null;
                          }
                          return "Please enter a valid email";
                        },
                      ),
                    ),
                    const Gap(30),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.20,
                      ),
                      child: CustomBtn(
                        label: 'Submit',
                        onTap: () {},
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        btnStyle: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          backgroundColor: ColorName.primary,
                          shape: const RoundedRectangleBorder(
                            // border radius
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
