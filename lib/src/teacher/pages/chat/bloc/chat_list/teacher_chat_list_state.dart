part of 'teacher_chat_list_bloc.dart';

class TeacherChatListState extends Equatable {
  final StudentListResponseModel studentList;
  final ViewStatus viewStatus;
  final String? errorMessage;

  const TeacherChatListState({
    required this.studentList,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
  });

  TeacherChatListState copyWith({
    StudentListResponseModel? studentList,
    ViewStatus? viewStatus,
    String? errorMessage,
  }) {
    return TeacherChatListState(
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

final class TeacherChatListInitial extends TeacherChatListState {
  const TeacherChatListInitial({required super.studentList});
}
