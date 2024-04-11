import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/resources/theme/theme.dart';
import 'package:ease_studyante_app/core/routes/routes.dart';
import 'package:ease_studyante_app/src/landing/presentation/landing_page.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/data/data_sources/teacher_profile_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/teacher_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EaseStudyanteApp extends StatefulWidget {
  const EaseStudyanteApp({super.key});
  static final navKey = GlobalKey<NavigatorState>();

  @override
  State<EaseStudyanteApp> createState() => _EaseStudyanteAppState();
}

class _EaseStudyanteAppState extends State<EaseStudyanteApp> {
  bool isNeedOnBoarded = true;
  late TeacherBloc teacherBloc;

  @override
  void initState() {
    super.initState();
    teacherBloc = TeacherBloc(TeacherProfileRepositoryImpl());
    initialization();
  }

  void initialization() async {
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => teacherBloc..add(SetTeacherProfileEvent()),
        ),
        BlocProvider<GlobalBloc>(
          create: (context) => GlobalBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: ((context, child) {
          return BlocBuilder<TeacherBloc, TeacherState>(
            builder: (context, state) {
              return MaterialApp(
                navigatorKey: EaseStudyanteApp.navKey,
                themeMode: ThemeMode.light,
                darkTheme: MaterialAppThemes.lightTheme,
                theme: MaterialAppThemes.lightTheme,
                onGenerateRoute: generateRoute,
                home: state is TeacherLoaded
                    ? const TeacherHomePage()
                    : const LandingPage(),
              );
            },
          );
        }),
      ),
    );
  }
}
