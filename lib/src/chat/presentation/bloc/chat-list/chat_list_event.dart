part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class OnGetStudentChatList extends ChatListEvent {}

class OnPaginateStudentChatList extends ChatListEvent {}
