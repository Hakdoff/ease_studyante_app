import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/chat/presentation/pages/widgets/chat_tile.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat/teacher_chat_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat_list/teacher_chat_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/data_sources/teacher_chat_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_search_chat_list_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class TeacherChatListScreen extends StatefulWidget {
  static const String routeName = '/teacher/chat-list';

  const TeacherChatListScreen({super.key});

  @override
  State<TeacherChatListScreen> createState() => _TeacherChatListScreenState();
}

class _TeacherChatListScreenState extends State<TeacherChatListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TeacherChatListBloc>().add(const OnSearchStudentEvent(' '));
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchField(
              onTap: () {
                Navigator.of(context).pushNamed(
                  TeacherSearchChatListScreen.routeName,
                );
              },
              readOnly: true,
              hintText: 'Search student...',
            ),
          ),
          BlocBuilder<TeacherChatListBloc, TeacherChatListState>(
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

              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.userListResponseModel.users.length,
                itemBuilder: (context, index) {
                  final user = state.userListResponseModel.users[index];
                  // ROOM_NAME student + teacher ids
                  return ChatTile(
                    id: user.pk,
                    name: '${user.firstName} ${user.lastName}',
                    onTap: () {
                      final teacherId = getCurrentUserId();

                      if (teacherId.isNotEmpty) {
                        final roomName = user.pk + teacherId;

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
                                    user: user,
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
            .read<TeacherChatListBloc>()
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
