import 'dart:convert';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserListResponseModel extends Equatable {
  final List<User> users;
  final String? nextPage;
  final int totalCount;

  const UserListResponseModel({
    required this.users,
    this.nextPage,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [
        users,
        nextPage,
        totalCount,
      ];

  factory UserListResponseModel.fromMap(Map<String, dynamic> map) {
    return UserListResponseModel(
      users: List<User>.from(map['results']?.map((x) => User.fromMap(x))),
      nextPage: map['next'],
      totalCount: map['count']?.toInt() ?? 0,
    );
  }

  UserListResponseModel copyWith({
    List<User>? users,
    String? nextPage,
    int? totalCount,
  }) {
    return UserListResponseModel(
      users: users ?? this.users,
      totalCount: totalCount ?? this.totalCount,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  factory UserListResponseModel.empty() =>
      const UserListResponseModel(users: [], totalCount: -1);

  factory UserListResponseModel.fromJson(String source) =>
      UserListResponseModel.fromMap(json.decode(source));
}
