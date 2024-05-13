import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_list_repository.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_list_repository_impl.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_repository.dart';
import 'package:ease_studyante_app/src/chat/presentation/bloc/chat-list/chat_list_bloc.dart';
import 'package:ease_studyante_app/src/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:ease_studyante_app/src/home/presentation/pages/student_home.dart';
import 'package:ease_studyante_app/src/login/data/data_sources/login_repository_impl.dart';
import 'package:ease_studyante_app/src/profile/data/data_sources/profile_repository_impl.dart';
import 'package:ease_studyante_app/src/profile/presentation/bloc/profile_bloc.dart';
import 'package:ease_studyante_app/src/schedule/repository/schedule_repository.dart';
import 'package:ease_studyante_app/src/schedule/repository/schedule_repository_impl.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/bloc/subject_bloc.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/teacher_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'bloc/login_bloc.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_body.dart';
import 'widgets/login_header.dart';

class LoginArgs {
  final bool isTeacher;
  final bool isStudent;
  final bool isParent;

  LoginArgs({
    required this.isTeacher,
    required this.isStudent,
    required this.isParent,
  });
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  static const String routeName = '/account/login';
  final LoginArgs args;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  late LoginBloc loginBloc;
  late ProfileBloc profileBloc;
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();
    final profileRepository = ProfileRepositoryImpl();
    loginBloc = LoginBloc(
      LoginRepositoryImpl(),
      profileRepository,
    );
    profileBloc = ProfileBloc(profileRepository);
    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) {
        if (state is ProfileLoaded) {
          globalBloc.add(
            StoreStudentProfileEvent(
              profile: state.profile,
            ),
          );
          handleNAvigate();
        }
      },
      child: BlocProvider(
        create: (context) => loginBloc,
        child: Scaffold(
          appBar: buildAppBar(
            context: context,
          ),
          body: ProgressHUD(
            child: Builder(builder: (context) {
              final progressHUD = ProgressHUD.of(context);
              String user = '';
              if (widget.args.isTeacher) {
                user = 'Teacher';
              } else if (widget.args.isParent) {
                user = 'Parent';
              } else if (widget.args.isStudent) {
                user = 'Student';
              }
              return BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    progressHUD?.show();
                  }

                  if (state is LoginSuccess || state is LoginError) {
                    progressHUD?.dismiss();

                    if (state is LoginSuccess) {
                      handleNavigate();
                    }

                    if (state is LoginError) {
                      handleErrorMessage(state.errorMessage);
                    }
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LoginHeader(
                        title: 'Login $user',
                      ),
                      const Gap(15),
                      LoginBody(
                        formKey: _formKey,
                        emailCtrl: emailCtrl,
                        passwordCtrl: passwordCtrl,
                        onSubmit: handleSubmit,
                        passwordVisible: _passwordVisible,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      const LoginFooter(),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      loginBloc.add(
        OnSubmitLoginEvent(
          emailAddress: emailCtrl.value.text,
          password: passwordCtrl.value.text,
          isTeacher: widget.args.isTeacher,
          isStudent: widget.args.isStudent,
          isParent: widget.args.isParent,
        ),
      );
    }
  }

  void handleErrorMessage(String errorMessage) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: errorMessage,
      ),
    );
  }

  void handleNavigate() {
    if (widget.args.isTeacher) {
      BlocProvider.of<TeacherBloc>(context).add(OnGetTeacherProfileEvent());

      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const TeacherHomePage(),
        ),
        ModalRoute.withName('/'),
      );
    } else if (widget.args.isStudent) {
      profileBloc.add(OnGetStudentProfileEvent());
    } else if (widget.args.isParent) {
      profileBloc.add(OnGetParentProfileEvent());
    }
    // return student view home
  }

  void handleNAvigate() {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ScheduleRepository>(
              create: (context) => ScheduleRepositoryImpl(),
            ),
            RepositoryProvider<ChatListRepository>(
              create: (context) => ChatListRepositoryImpl(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SubjectBloc>(
                create: (context) => SubjectBloc(
                  scheduleRepository:
                      RepositoryProvider.of<ScheduleRepository>(context),
                ),
              ),
              BlocProvider<ChatListBloc>(
                create: (context) => ChatListBloc(
                  RepositoryProvider.of<ChatListRepository>(context),
                ),
              ),
              BlocProvider<ChatBloc>(
                create: (context) => ChatBloc(
                  RepositoryProvider.of<ChatRepository>(context),
                ),
              )
            ],
            child: StudentHome(
              isParent: widget.args.isParent,
            ),
          ),
        ),
      ),
      ModalRoute.withName('/'),
    );
  }
}
