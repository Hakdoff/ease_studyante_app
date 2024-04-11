import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/profile/domain/entities/teacher.dart';

class ChatListModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<Teacher> teachers;

  const ChatListModel({
    this.nextPage,
    required this.totalCount,
    required this.teachers,
  });

  ChatListModel copyWith({
    String? nextPage,
    int? totalCount,
    List<Teacher>? teachers,
  }) {
    return ChatListModel(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      teachers: teachers ?? this.teachers,
    );
  }

  @override
  String toString() =>
      'ChatListModel(nextPage: $nextPage, totalCount: $totalCount, teachers: $teachers)';

  factory ChatListModel.empty() =>
      const ChatListModel(teachers: [], totalCount: -1);

  @override
  List<Object?> get props => [nextPage, totalCount, teachers];
}
