import 'dart:async';

import 'package:ease_studyante_app/src/chat/data/models/chat_list_model.dart';

abstract class ChatListRepository {
  FutureOr<ChatListModel> getChatList({String? nextPage});
}
