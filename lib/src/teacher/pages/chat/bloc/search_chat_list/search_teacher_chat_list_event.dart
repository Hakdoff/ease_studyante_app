part of 'search_teacher_chat_list_bloc.dart';

abstract class SearchTeacherChatListEvent extends Equatable {
  const SearchTeacherChatListEvent();

  @override
  List<Object> get props => [];
}

class OnSearchStudentEvent extends SearchTeacherChatListEvent {
  final String q;

  const OnSearchStudentEvent(this.q);

  @override
  List<Object> get props => [q];
}

class OnPaginateSearchStudentEventt extends SearchTeacherChatListEvent {
  final String q;

  const OnPaginateSearchStudentEventt(this.q);

  @override
  List<Object> get props => [q];
}
