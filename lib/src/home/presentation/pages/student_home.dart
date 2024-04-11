import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/custom_text.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/change_password/data/blocs/bloc/change_password_bloc.dart';
import 'package:ease_studyante_app/src/change_password/data/repository/change_password_repository.dart';
import 'package:ease_studyante_app/src/change_password/data/repository/change_password_repository_impl.dart';
import 'package:ease_studyante_app/src/change_password/presentation/pages/change_password_screen.dart';
import 'package:ease_studyante_app/src/chat/presentation/pages/chat_list_screen.dart';
import 'package:ease_studyante_app/src/home/presentation/pages/student_drawer.dart';
import 'package:ease_studyante_app/src/landing/presentation/landing_page.dart';

import 'package:ease_studyante_app/src/subject/presentation/pages/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  late GlobalBloc globalBloc;
  List<Widget> screens = const [
    SubjectScreen(),
    ChatListScreen(),
  ];

  final iconList = <IconData>[
    Icons.home,
    Icons.chat_bubble,
  ];

  @override
  void initState() {
    super.initState();
    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalBloc, GlobalState>(
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
                    isStudent: true,
                  ),
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, index, child) {
            return Scaffold(
              extendBody: true,
              body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: screens.elementAt(index),
              ),
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
              drawer: StudentDrawer(
                onTapLogout: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LandingPage.routeName, (route) => false);
                },
                globalBloc: globalBloc,
                section: state.studentSection,
              ),
              bottomNavigationBar: AnimatedBottomNavigationBar(
                height: 60,
                icons: iconList,
                activeIndex: index,
                leftCornerRadius: 20,
                rightCornerRadius: 20,
                activeColor: Colors.white,
                inactiveColor: ColorName.placeHolder,
                backgroundColor: ColorName.primary,
                onTap: (currentIndex) {
                  selectedIndex.value = currentIndex;
                },
                gapLocation: GapLocation.none,
              ),
            );
          },
        );
      },
    );
  }
}
