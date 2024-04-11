import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/change_password/data/blocs/bloc/change_password_bloc.dart';
import 'package:ease_studyante_app/src/change_password/data/repository/change_password_repository.dart';
import 'package:ease_studyante_app/src/change_password/data/repository/change_password_repository_impl.dart';
import 'package:ease_studyante_app/src/change_password/presentation/pages/change_password_screen.dart';
import 'package:ease_studyante_app/src/landing/presentation/landing_page.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat_list/teacher_chat_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/data_sources/teacher_chat_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_list_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/data/data_sources/teacher_schedule_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/presentation/widgets/teacher_drawer.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/presentation/teacher_qr_code_scanner.dart';
import 'package:ease_studyante_app/src/teacher/pages/schedule/presentation/bloc/teacher_schedule_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/schedule/presentation/teacher_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class TeacherHomePage extends StatefulWidget {
  static const String routeName = '/';
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  late TeacherScheduleBloc teacherScheduleBloc;
  late GlobalBloc globalBloc;
  int _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.qr_code,
    Icons.chat_bubble,
  ];

  final pages = [
    const TeacherSchedulePage(),
    const TeacherQRCodeScanner(),
    const TeacherChatListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    teacherScheduleBloc = TeacherScheduleBloc(TeacherScheduleRepositoryImpl());
    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                teacherScheduleBloc..add(OnGetTeacherScheduleEvent())),
        BlocProvider(
            create: (context) =>
                TeacherChatListBloc(TeacherChatRepositoryImpl())),
      ],
      child: BlocListener<GlobalBloc, GlobalState>(
        bloc: globalBloc,
        listener: (context, state) {
          if (state.studentProfile.isNewUser) {
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 250),
                type: PageTransitionType.fade,
                child: RepositoryProvider<ChangePasswordRepository>(
                  create: (context) => ChangePasswordRepositoryImpl(),
                  child: BlocProvider<ChangePasswordBloc>(
                    create: (context) => ChangePasswordBloc(
                      changePasswordRepository:
                          RepositoryProvider.of<ChangePasswordRepository>(
                              context),
                    ),
                    child: const ChangePasswordScreen(
                      isStudent: false,
                    ),
                  ),
                ),
              ),
            );
          }
        },
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
