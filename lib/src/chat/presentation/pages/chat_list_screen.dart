import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/chat/presentation/bloc/chat-list/chat_list_bloc.dart';
import 'package:ease_studyante_app/src/chat/presentation/pages/chat_screen.dart';
import 'package:ease_studyante_app/src/chat/presentation/pages/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatListBloc>().add(OnGetStudentChatList());
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.viewStatus == ViewStatus.failed) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          return ListView.separated(
            itemCount: state.chatListModel.teachers.length,
            itemBuilder: (context, index) {
              final teacher = state.chatListModel.teachers[index];
              // ROOM_NAME student + teacher ids
              return ChatTile(
                id: teacher.pk,
                name: '${teacher.firstName} ${teacher.lastName}',
                onTap: () {
                  final studentId = getCurrentUserId();

                  if (studentId.isNotEmpty) {
                    final roomName = studentId + teacher.pk;

                    Navigator.of(context).pushNamed(
                      ChatScreen.routeName,
                      arguments: ChatArgs(
                        teacher: teacher,
                        rooName: roomName,
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
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        context.read<ChatListBloc>().add(OnPaginateStudentChatList());
      }
    });
  }

  String getCurrentUserId() {
    final state = context.read<GlobalBloc>().state;

    return state.studentProfile.pk;
  }
}
