import 'dart:convert';

import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/chat_bubble.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/domain/entities/teacher.dart';

class ChatArgs {
  final Teacher teacher;
  final String rooName;

  ChatArgs({
    required this.teacher,
    required this.rooName,
  });
}

class ChatScreen extends StatefulWidget {
  final ChatArgs args;
  static const String routeName = '/student/chat-screen';

  const ChatScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Uri wsUrl;
  late IOWebSocketChannel channel;
  final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<bool> isDisabled = ValueNotifier(true);
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(OnGetInitialChat());
    globalBloc = context.read<GlobalBloc>();
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
          title:
              '${widget.args.teacher.firstName} ${widget.args.teacher.lastName}'),
      body: BlocBuilder<ChatBloc, ChatState>(
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
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final chat = state.chatModel.chats[index];

                      return ChatBubble(
                        isSender: globalBloc.state.studentProfile.email ==
                            chat.username,
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
      final userEmail = globalBloc.state.studentProfile.email;

      final Map<String, dynamic> data = {
        "message": message,
        "username": userEmail,
      };
      channel.sink.add(json.encode(data));
      textEditingController.clear();
    }
  }

  Future<void> initChannel() async {
    // set loading when trying to connect in websocket
    context.read<ChatBloc>().add(OnTryConnectToWebSocket());

    try {
      // student_id + teacher_id
      String roomName = widget.args.rooName;
      wsUrl = Uri.parse('wss://${AppConstant.serverHost}/ws/chat/$roomName/');
      channel = IOWebSocketChannel.connect(wsUrl);

      await channel.ready;

      if (mounted) {
        // set isConnected to true when already connected to websocket otherwise false

        context
            .read<ChatBloc>()
            .add(const OnGetConnectWebSocket(isConnected: true));
      }

      channel.stream.listen((message) {
        context.read<ChatBloc>().add(OnReceivedMessageChat(message: message));
      });
    } catch (e) {
      context
          .read<ChatBloc>()
          .add(const OnGetConnectWebSocket(isConnected: false));
    }
  }
}
