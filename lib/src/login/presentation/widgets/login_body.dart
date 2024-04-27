import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:ease_studyante_app/gen/colors.gen.dart';

import '../../../../core/common_widget/common_widget.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.formKey,
    required this.suffixIcon,
    required this.onSubmit,
    required this.passwordVisible,
  }) : super(key: key);

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final GlobalKey formKey;
  final Widget suffixIcon;
  final VoidCallback onSubmit;
  final bool passwordVisible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email Address',
                parametersValidate: 'required',
                keyboardType: TextInputType.emailAddress,
                textController: emailCtrl,
                validators: (value) {
                  if (value != null && EmailValidator.validate(value)) {
                    return null;
                  }
                  return "Please enter a valid email";
                },
              ),
              CustomTextField(
                labelText: 'Password',
                parametersValidate: 'required',
                textController: passwordCtrl,
                validators: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: !passwordVisible,
                suffixIcon: suffixIcon,
              ),
              const Gap(10),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.20,
                ),
                child: CustomBtn(
                  label: 'Login',
                  onTap: onSubmit,
                  style: const TextStyle(
                    color: Colors.white,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
