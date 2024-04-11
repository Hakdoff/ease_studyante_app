import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/chat/presentation/pages/widgets/chat_tile.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat/teacher_chat_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/search_chat_list/search_teacher_chat_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/data_sources/teacher_chat_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class TeacherSearchChatListScreen extends StatefulWidget {
  static const String routeName = '/teacher/chat-list/search';

  const TeacherSearchChatListScreen({super.key});

  @override
  State<TeacherSearchChatListScreen> createState() =>
      _TeacherSearchChatListScreenState();
}

class _TeacherSearchChatListScreenState
    extends State<TeacherSearchChatListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context
        .read<SearchTeacherChatListBloc>()
        .add(const OnSearchStudentEvent(' '));
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Search'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchField(
              onTap: () {},
              hintText: 'Search student...',
              onFieldSubmitted: (value) {
                context
                    .read<SearchTeacherChatListBloc>()
                    .add(OnSearchStudentEvent(value));
              },
            ),
          ),
          BlocBuilder<SearchTeacherChatListBloc, SearchTeacherChatListState>(
            builder: (context, state) {
              if (state.viewStatus == ViewStatus.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state.viewStatus == ViewStatus.failed) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (state.studentList.students.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          size: 50,
                        ),
                        Text('Student not found'),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                itemCount: state.studentList.students.length,
                itemBuilder: (context, index) {
                  final student = state.studentList.students[index];
                  // ROOM_NAME student + teacher ids
                  return ChatTile(
                    id: student.user.pk,
                    name: '${student.user.firstName} ${student.user.lastName}',
                    onTap: () {
                      final teacherId = getCurrentUserId();

                      if (teacherId.isNotEmpty) {
                        final roomName = student.user.pk + teacherId;

                        Navigator.push(
                          context,
                          PageTransition(
                            child: RepositoryProvider<TeacherChatRepository>(
                              create: (context) => TeacherChatRepositoryImpl(),
                              child: BlocProvider<TeacherChatBloc>(
                                create: (context) => TeacherChatBloc(
                                  RepositoryProvider.of<TeacherChatRepository>(
                                      context),
                                ),
                                child: TeacherChatScreen(
                                  args: TeacherChatArgs(
                                    rooName: roomName,
                                    student: student,
                                  ),
                                ),
                              ),
                            ),
                            duration: const Duration(milliseconds: 250),
                            type: PageTransitionType.fade,
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1, height: 0),
              );
            },
          )
        ],
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        context
            .read<SearchTeacherChatListBloc>()
            .add(const OnPaginateSearchStudentEventt(' '));
      }
    });
  }

  String getCurrentUserId() {
    final state = BlocProvider.of<TeacherBloc>(context).state;

    if (state is TeacherLoaded) {
      return state.teacher.pk;
    }

    return '';
  }
}
