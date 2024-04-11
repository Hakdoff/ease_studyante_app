import 'dart:convert';

import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/bloc/teacher_chat_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/chat_bubble.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/chat_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/io.dart';

import 'package:flutter/material.dart';

class TeacherChatScreen extends StatefulWidget {
  static const String routeName = '/teacher/chat';

  const TeacherChatScreen({super.key});

  @override
  State<TeacherChatScreen> createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  late Uri wsUrl;
  late IOWebSocketChannel channel;
  late String email;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<TeacherChatBloc>().add(OnGetInitialChat());
    email = getUserEmail();
    // initialize websocket channel
    initChannel();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(status.goingAway);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Chat'),
      body: BlocBuilder<TeacherChatBloc, TeacherChatState>(
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          return SizedBox.expand(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final chat = state.chatModel.chats[index];

                      return ChatBubble(
                        isSender: isSender(chat.username),
                        message: chat.message,
                        timeStamp: chat.timeStamp,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: state.chatModel.chats.length,
                  ),
                ),
                ChatInput(
                  controller: textEditingController,
                  onSend: (value) {
                    onSendChatMessage(value);
                  },
                  isDisabled: textEditingController.value.text.isEmpty,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> onSendChatMessage(String message) async {
    if (message.isNotEmpty) {
      final Map<String, dynamic> data = {
        "message": message,
        "username": email,
      };
      channel.sink.add(json.encode(data));
      textEditingController.clear();
    }
  }

  bool isSender(String email) {
    final state = context.read<TeacherBloc>().state;

    if (state is TeacherLoaded) {
      return state.teacher.email.toLowerCase() == email.toLowerCase();
    }
    return false;
  }

  String getUserEmail() {
    final state = context.read<TeacherBloc>().state;

    if (state is TeacherLoaded) {
      return state.teacher.email;
    }

    return '';
  }

  Future<void> initChannel() async {
    // set loading when trying to connect in websocket
    context.read<TeacherChatBloc>().add(OnTryConnectToWebSocket());

    try {
      // student_id + teacher_id
      String roomName =
          'da2ecb1c-d6bd-4ba1-9142-a345dbcc5e27edf6bd03-a331-4ccf-8825-8cfd2c268ae8';
      wsUrl = Uri.parse('ws://${AppConstant.serverHost}/ws/chat/$roomName/');
      channel = IOWebSocketChannel.connect(wsUrl);

      await channel.ready;

      if (mounted) {
        // set isConnected to true when already connected to websocket otherwise false

        context
            .read<TeacherChatBloc>()
            .add(const OnGetConnectWebSocket(isConnected: true));
      }

      channel.stream.listen((message) {
        context
            .read<TeacherChatBloc>()
            .add(OnReceivedMessageChat(message: message));
      });
    } catch (e) {
      context
          .read<TeacherChatBloc>()
          .add(const OnGetConnectWebSocket(isConnected: false));
    }
  }
}
