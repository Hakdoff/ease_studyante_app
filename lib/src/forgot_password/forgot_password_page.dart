import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/forgot_password/data/blocs/bloc/forgot_password_bloc.dart';
import 'package:ease_studyante_app/src/login/presentation/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ValueNotifier<bool> isForgotPasswordValid = ValueNotifier(true);
  late ForgotPasswordBloc forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Forgot Password"),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        bloc: forgotPasswordBloc,
        listener: (context, state) {
          if (state.viewStatus == ViewStatus.successful) {
            CommonDialog.showMyDialog(
              context: context,
              body: state.forgotPassswordResponse.success,
            ).then(
              (value) {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(
                    LoginPage.routeName,
                  ),
                );
              },
            );
          }

          if (state.viewStatus == ViewStatus.failed) {
            CommonDialog.showMyDialog(
              context: context,
              body: 'Oops! Something went wrong please try again later',
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                          child: ValueListenableBuilder(
                            valueListenable: isForgotPasswordValid,
                            builder: (context, isForgotPasswordValid, child) {
                              return SpacedColumn(
                                children: [
                                  CustomTextField(
                                    textController: emailController,
                                    labelText: "Email Address",
                                    keyboardType: TextInputType.emailAddress,
                                    padding: EdgeInsets.zero,
                                    parametersValidate: 'required',
                                    validators: (value) {
                                      if (value != null &&
                                          EmailValidator.validate(value)) {
                                        return null;
                                      }
                                      return "Please enter a valid email";
                                    },
                                  ),
                                  if (!isForgotPasswordValid) ...[
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      child: Text(
                                        'Please enter a valid email',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ],
                              );
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
                            onTap: () {
                              isForgotPasswordValid.value = emailController
                                      .text.isNotEmpty &&
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);
                              if (isForgotPasswordValid.value) {
                                forgotPasswordBloc.add(
                                  SendForgotPasswordEvent(
                                    email: emailController.text,
                                  ),
                                );
                              }
                            },
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
          );
        },
      ),
    );
  }
}
