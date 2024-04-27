part of 'teacher_chat_list_bloc.dart';

class TeacherChatListState extends Equatable {
  final UserListResponseModel userListResponseModel;
  final ViewStatus viewStatus;
  final String? errorMessage;

  const TeacherChatListState({
    required this.userListResponseModel,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
  });

  TeacherChatListState copyWith({
    UserListResponseModel? userListResponseModel,
    ViewStatus? viewStatus,
    String? errorMessage,
  }) {
    return TeacherChatListState(
      userListResponseModel:
          userListResponseModel ?? this.userListResponseModel,
      viewStatus: viewStatus ?? this.viewStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        userListResponseModel,
        viewStatus,
        errorMessage,
      ];
}

final class TeacherChatListInitial extends TeacherChatListState {
  const TeacherChatListInitial({required super.userListResponseModel});
}
