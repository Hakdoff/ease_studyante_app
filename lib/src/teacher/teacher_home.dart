import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/pages/attendance_practice.dart';
import 'package:ease_studyante_app/src/landing/presentation/landing_page.dart';
import 'package:ease_studyante_app/src/qr_practice/presentation/qr_practice.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_list_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/data/data_sources/teacher_schedule_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/presentation/widgets/teacher_drawer.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/presentation/teacher_qr_code_scanner.dart';
import 'package:ease_studyante_app/src/teacher/pages/schedule/presentation/bloc/teacher_schedule_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/schedule/presentation/teacher_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherHomePage extends StatefulWidget {
  static const String routeName = '/';
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  late TeacherScheduleBloc teacherScheduleBloc;

  int _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.qr_code,
    Icons.chat_bubble,
    Icons.qr_code_2_outlined,
  ];

  final pages = [
    const TeacherSchedulePage(),
    const TeacherQRCodeScanner(),
    const TeacherChatListScreen(),
    const QrPractice(),
  ];

  @override
  void initState() {
    super.initState();
    teacherScheduleBloc = TeacherScheduleBloc(TeacherScheduleRepositoryImpl());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          teacherScheduleBloc..add(OnGetTeacherScheduleEvent()),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const CustomText(
            style: TextStyle(
              color: Colors.white,
            ),
            text: AppConstant.appName,
          ),
          backgroundColor: ColorName.primary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: pages[_bottomNavIndex],
        ),
        drawer: TeacherDrawer(
          onTapLogout: handleLogout,
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 60,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          activeColor: Colors.white,
          inactiveColor: ColorName.placeHolder,
          backgroundColor: ColorName.primary,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          gapLocation: GapLocation.none,
        ),
      ),
    );
  }

  void handleLogout() async {
    await LocalStorage.deleteLocalStorage('_teacher');
    await LocalStorage.deleteLocalStorage('_token');
    await LocalStorage.deleteLocalStorage('_refreshToken');

    if (mounted) {
      BlocProvider.of<TeacherBloc>(context).add(OnTeacherLogout());
      Navigator.pushNamedAndRemoveUntil(
          context, LandingPage.routeName, (route) => false);
    }
  }
}
