import 'package:ease_studyante_app/src/profile/presentation/pages/teacher_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:page_transition/page_transition.dart';

class TeacherDrawer extends StatelessWidget {
  const TeacherDrawer({
    Key? key,
    required this.onTapLogout,
  }) : super(key: key);

  final VoidCallback onTapLogout;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoaded) {
          final profile = state.teacher;

          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: ColorName.primary,
                  ),
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            style: const TextStyle(color: Colors.white),
                            text: '${profile.firstName} ${profile.lastName}'),
                        CustomText(
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                          text: profile.email,
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  trailing: const Icon(Icons.person),
                  title: const CustomText(
                    text: 'Account',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 250),
                        type: PageTransitionType.fade,
                        child: TeacherProfile(
                          profile: profile,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.power_settings_new),
                  title: const CustomText(
                    text: 'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ColorName.placeHolder),
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const CustomText(text: AppConstant.appName),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const CustomText(text: 'Cancel'),
                        ),
                        TextButton(
                          onPressed: onTapLogout,
                          child: const CustomText(
                            text: 'OK',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
