import 'dart:convert';

import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/teacher/bloc/teacher_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/bloc/chat/teacher_chat_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/chat_bubble.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/chat_input.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/io.dart';

import 'package:flutter/material.dart';

class TeacherChatArgs {
  final User user;
  final String rooName;

  TeacherChatArgs({
    required this.user,
    required this.rooName,
  });
}

class TeacherChatScreen extends StatefulWidget {
  static const String routeName = '/teacher/chat';

  final TeacherChatArgs args;

  const TeacherChatScreen({super.key, required this.args});

  @override
  State<TeacherChatScreen> createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  late Uri wsUrl;
  late IOWebSocketChannel channel;
  late String email;
  final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<bool> isDisabled = ValueNotifier(true);

  @override
  void initState() {
    super.initState();

    context.read<TeacherChatBloc>().add(OnGetInitialChat());
    email = getUserEmail();
    // initialize websocket channel
    initChannel();

    textEditingController.addListener(() {
      isDisabled.value = textEditingController.value.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(status.goingAway);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: '${widget.args.user.firstName} ${widget.args.user.lastName}'),
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
                ValueListenableBuilder(
                  valueListenable: isDisabled,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return ChatInput(
                      controller: textEditingController,
                      onSend: (value) {
                        onSendChatMessage(value);
                      },
                      isDisabled: value,
                    );
                  },
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
      String roomName = widget.args.rooName;
      wsUrl = Uri.parse('wss://${AppConstant.serverHost}/ws/chat/$roomName/');
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
      // ignore: use_build_context_synchronously
      context
          .read<TeacherChatBloc>()
          .add(const OnGetConnectWebSocket(isConnected: false));
    }
  }
}
