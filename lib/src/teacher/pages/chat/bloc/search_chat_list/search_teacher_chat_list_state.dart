part of 'search_teacher_chat_list_bloc.dart';

class SearchTeacherChatListState extends Equatable {
  final StudentListResponseModel studentList;
  final ViewStatus viewStatus;
  final String? errorMessage;

  const SearchTeacherChatListState({
    required this.studentList,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
  });

  SearchTeacherChatListState copyWith({
    StudentListResponseModel? studentList,
    ViewStatus? viewStatus,
    String? errorMessage,
  }) {
    return SearchTeacherChatListState(
      studentList: studentList ?? this.studentList,
      viewStatus: viewStatus ?? this.viewStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        studentList,
        viewStatus,
        errorMessage,
      ];
}

final class SearchTeacherChatListInitial extends SearchTeacherChatListState {
  const SearchTeacherChatListInitial({required super.studentList});
}
