part of 'teacher_chat_list_bloc.dart';

class TeacherChatListState extends Equatable {
  final UserListResponseModel userListResponseModel;
  final ChatSessionModel chatSessionModel;
  final ViewStatus viewStatus;
  final String? errorMessage;

  const TeacherChatListState({
    required this.userListResponseModel,
    required this.chatSessionModel,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
  });

  TeacherChatListState copyWith({
    UserListResponseModel? userListResponseModel,
    ViewStatus? viewStatus,
    String? errorMessage,
    ChatSessionModel? chatSessionModel,
  }) {
    return TeacherChatListState(
      chatSessionModel: chatSessionModel ?? this.chatSessionModel,
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
        chatSessionModel,
      ];
}

final class TeacherChatListInitial extends TeacherChatListState {
  const TeacherChatListInitial(
      {required super.userListResponseModel, required super.chatSessionModel});
}
