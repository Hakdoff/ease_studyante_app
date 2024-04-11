import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/profile/presentation/pages/student_profile.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({
    super.key,
    required this.onTapLogout,
    required this.globalBloc,
    required this.section,
  });

  final VoidCallback onTapLogout;
  final GlobalBloc globalBloc;
  final Section section;

  @override
  Widget build(BuildContext context) {
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
                      text:
                          '${globalBloc.state.studentProfile.firstName} ${globalBloc.state.studentProfile.lastName}'),
                  CustomText(
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    text: globalBloc.state.studentProfile.email,
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
                  child: StudentProfile(
                    profile: globalBloc.state.studentProfile,
                    section: section,
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
                  fontWeight: FontWeight.normal, color: ColorName.placeHolder),
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
}
