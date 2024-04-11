import 'package:ease_studyante_app/src/teacher/pages/chat/presentation/teacher_chat_screen.dart';
import 'package:flutter/material.dart';

class TeacherChatListScreen extends StatefulWidget {
  static const String routeName = '/teacher/chat-list';

  const TeacherChatListScreen({super.key});

  @override
  State<TeacherChatListScreen> createState() => _TeacherChatListScreenState();
}

class _TeacherChatListScreenState extends State<TeacherChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(TeacherChatScreen.routeName);
      },
      child: const Text(
        'Tap to chat',
      ),
    );
  }
}
