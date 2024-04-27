part of 'search_teacher_chat_list_bloc.dart';

class SearchTeacherChatListState extends Equatable {
  final UserListResponseModel userListResponseModel;
  final ViewStatus viewStatus;
  final String? errorMessage;

  const SearchTeacherChatListState({
    required this.userListResponseModel,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
  });

  SearchTeacherChatListState copyWith({
    UserListResponseModel? userListResponseModel,
    ViewStatus? viewStatus,
    String? errorMessage,
  }) {
    return SearchTeacherChatListState(
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

final class SearchTeacherChatListInitial extends SearchTeacherChatListState {
  const SearchTeacherChatListInitial({required super.userListResponseModel});
}
