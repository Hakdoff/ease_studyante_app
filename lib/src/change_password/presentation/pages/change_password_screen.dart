import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';

import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/change_password/data/blocs/bloc/change_password_bloc.dart';
import 'package:ease_studyante_app/src/login/presentation/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common_widget/common_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool isStudent;
  const ChangePasswordScreen({
    super.key,
    required this.isStudent,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isCurrentPasswordValid = ValueNotifier(true);
  ValueNotifier<bool> isNewPasswordValid = ValueNotifier(true);
  ValueNotifier<bool> isConfirmPasswordValid = ValueNotifier(true);
  late ChangePasswordBloc changePasswordBloc;
  @override
  void initState() {
    super.initState();
    changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Change Password"),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        bloc: changePasswordBloc,
        listener: (context, state) {
          if (state.viewStatus == ViewStatus.successful) {
            CommonDialog.showMyDialog(
              context: context,
              body: state.response.message,
            ).then(
              (value) {
                Navigator.pop(context);
              },
            );
          }

          if (state.viewStatus == ViewStatus.failed) {
            CommonDialog.showMyDialog(
              context: context,
              body: state.errorMessage.isNotEmpty
                  ? state.errorMessage
                  : 'Oops! Something went wrong please try again later',
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SpacedColumn(
                  spacing: 20,
                  children: [
                    const LoginHeader(
                      title: '',
                    ),
                    ValueListenableBuilder(
                      valueListenable: isCurrentPasswordValid,
                      builder: (context, isCurrentPasswordValid, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              labelText: 'Current Password',
                              parametersValidate: 'required',
                              keyboardType: TextInputType.text,
                              textController: currentPassword,
                              validators: (value) {
                                if (value != null) {
                                  return null;
                                }
                                return "This field is required";
                              },
                            ),
                            if (!isCurrentPasswordValid) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'This field is required',
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
                    ValueListenableBuilder(
                      valueListenable: isNewPasswordValid,
                      builder: (context, isNewPasswordValid, child) {
                        return SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              labelText: 'New Password',
                              parametersValidate: 'required',
                              keyboardType: TextInputType.text,
                              textController: newPassword,
                              validators: (value) {
                                if (value != null) {
                                  return null;
                                }
                                return "This field is required";
                              },
                            ),
                            if (!isNewPasswordValid) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'This field is required',
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
                    ValueListenableBuilder(
                      valueListenable: isConfirmPasswordValid,
                      builder: (context, isConfirmPasswordValid, child) {
                        return SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              labelText: 'Confirm Password',
                              parametersValidate: 'required',
                              keyboardType: TextInputType.text,
                              textController: confirmPassword,
                              validators: (value) {
                                if (value != null) {
                                  return null;
                                }

                                if (newPassword.text != confirmPassword.text) {
                                  return 'Password must be the same';
                                }

                                return "This field is required";
                              },
                            ),
                            if (!isConfirmPasswordValid) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'Password must be the same',
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.20,
                        top: 60,
                      ),
                      child: CustomBtn(
                        label: 'Submit',
                        onTap: () {
                          isCurrentPasswordValid.value =
                              currentPassword.text.isNotEmpty;
                          isNewPasswordValid.value =
                              newPassword.text.isNotEmpty;
                          isConfirmPasswordValid.value =
                              newPassword.text == confirmPassword.text &&
                                  confirmPassword.text.isNotEmpty;

                          if (isCurrentPasswordValid.value &&
                              isNewPasswordValid.value &&
                              isConfirmPasswordValid.value) {
                            changePasswordBloc.add(
                              CallChangePasswordEvent(
                                oldPassword: currentPassword.text,
                                newPassword: newPassword.text,
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
