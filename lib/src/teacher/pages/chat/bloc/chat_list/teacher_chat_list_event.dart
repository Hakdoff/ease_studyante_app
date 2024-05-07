part of 'teacher_chat_list_bloc.dart';

abstract class TeacherChatListEvent extends Equatable {
  const TeacherChatListEvent();

  @override
  List<Object> get props => [];
}

class OnGetChatList extends TeacherChatListEvent {}

class OnSearchStudentEvent extends TeacherChatListEvent {
  final String q;

  const OnSearchStudentEvent(this.q);

  @override
  List<Object> get props => [q];
}

class OnPaginateSearchStudentEventt extends TeacherChatListEvent {
  final String q;

  const OnPaginateSearchStudentEventt(this.q);

  @override
  List<Object> get props => [q];
}
