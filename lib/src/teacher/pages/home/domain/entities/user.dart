import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String pk;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;

  const User({
    required this.pk,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
  });

  User copyWith({
    String? pk,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
  }) {
    return User(
      pk: pk ?? this.pk,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      pk: map['pk'] ?? '',
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      fullName: map['get_full_name'] ?? '',
    );
  }

  factory User.empty() {
    return const User(
      pk: '',
      email: '',
      firstName: '',
      lastName: '',
      fullName: '',
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      pk,
      email,
      firstName,
      lastName,
      fullName,
    ];
  }
}
