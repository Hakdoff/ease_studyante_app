import 'package:ease_studyante_app/src/forgot_password/data/blocs/bloc/forgot_password_bloc.dart';
import 'package:ease_studyante_app/src/forgot_password/data/repository/forgot_password_repository.dart';
import 'package:ease_studyante_app/src/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 250),
              type: PageTransitionType.fade,
              child: RepositoryProvider<ForgotPasswordRepository>(
                create: (context) => ForgotPasswordRepositoryImpl(),
                child: BlocProvider<ForgotPasswordBloc>(
                  create: (context) => ForgotPasswordBloc(
                    forgotPasswordRepository:
                        RepositoryProvider.of<ForgotPasswordRepository>(
                            context),
                  ),
                  child: const ForgotPasswordPage(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
