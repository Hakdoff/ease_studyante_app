import 'package:ease_studyante_app/src/chat/data/repository/chat_repository.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_repository_impl.dart';
import 'package:ease_studyante_app/src/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:ease_studyante_app/src/chat/presentation/pages/chat_screen.dart';
import 'package:ease_studyante_app/src/landing/presentation/landing_page.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat/teacher_chat_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat_list/teacher_chat_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/search_chat_list/search_teacher_chat_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/data_sources/teacher_chat_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_list_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_search_chat_list_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/presentation/teacher_qr_code_scanner.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/data/data_sources/student_list_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/domain/repositories/student_list_reopsitory.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/bloc/student_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/student_detail.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/student_list.dart';
import 'package:ease_studyante_app/src/teacher/teacher_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../src/forgot_password/forgot_password_page.dart';
import '../../src/login/presentation/login_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingPage.routeName:
      return PageTransition(
        child: const LandingPage(),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );
    case LoginPage.routeName:
      final args = settings.arguments! as LoginArgs;
      return PageTransition(
        child: LoginPage(args: args),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case ForgotPasswordPage.routeName:
      return PageTransition(
        child: const ForgotPasswordPage(),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case TeacherHomePage.routeName:
      return PageTransition(
        child: const TeacherHomePage(),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case TeacherQRCodeScanner.routeName:
      return PageTransition(
        child: const TeacherQRCodeScanner(),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case StudentListPage.routeName:
      final args = settings.arguments! as StudentListArgs;
      return PageTransition(
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<StudentListRepository>(
              create: (context) => StudentListRepositoryImpl(),
            ),
            RepositoryProvider<TeacherAttendanceRepository>(
              create: (context) => TeacherAttendanceRepositoryImpl(),
            ),
          ],
          child: BlocProvider<StudentListBloc>(
            create: (context) => StudentListBloc(
              RepositoryProvider.of<StudentListRepository>(context),
              RepositoryProvider.of<TeacherAttendanceRepository>(context),
            ),
            child: StudentListPage(
              args: args,
            ),
          ),
        ),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case StudentDetailPage.routeName:
      final args = settings.arguments! as StudentDetailArgs;

      return PageTransition(
        child: StudentDetailPage(
          schedule: args.schedule,
          student: args.student,
        ),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case TeacherChatListScreen.routeName:
      return PageTransition(
        child: RepositoryProvider<TeacherChatRepository>(
          create: (context) => TeacherChatRepositoryImpl(),
          child: BlocProvider<TeacherChatListBloc>(
            create: (context) => TeacherChatListBloc(
              RepositoryProvider.of<TeacherChatRepository>(context),
            ),
            child: const TeacherChatListScreen(),
          ),
        ),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case TeacherChatScreen.routeName:
      final args = settings.arguments! as TeacherChatArgs;

      return PageTransition(
        child: RepositoryProvider<TeacherChatRepository>(
          create: (context) => TeacherChatRepositoryImpl(),
          child: BlocProvider<TeacherChatBloc>(
            create: (context) => TeacherChatBloc(
              RepositoryProvider.of<TeacherChatRepository>(context),
            ),
            child: TeacherChatScreen(
              args: args,
            ),
          ),
        ),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case ChatScreen.routeName:
      final args = settings.arguments! as ChatArgs;
      return PageTransition(
        child: RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepositoryImpl(),
          child: BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(
              RepositoryProvider.of<ChatRepository>(context),
            ),
            child: ChatScreen(args: args),
          ),
        ),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );

    case TeacherSearchChatListScreen.routeName:
      return PageTransition(
        child: RepositoryProvider<TeacherChatRepository>(
          create: (context) => TeacherChatRepositoryImpl(),
          child: BlocProvider<SearchTeacherChatListBloc>(
            create: (context) => SearchTeacherChatListBloc(
              RepositoryProvider.of<TeacherChatRepository>(context),
            ),
            child: const TeacherSearchChatListScreen(),
          ),
        ),
        duration: const Duration(milliseconds: 250),
        settings: settings,
        type: PageTransitionType.fade,
      );
  }

  return PageTransition(
    child: const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text('Something went wrong'),
      ),
    ),
    duration: const Duration(milliseconds: 250),
    settings: settings,
    type: PageTransitionType.fade,
  );
}
