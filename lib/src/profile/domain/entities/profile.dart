import 'dart:convert';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';

class Profile {
  final String pk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePk;
  final String? profilePhoto;
  final String gender;
  final bool isNewUser;
  final List<Student>? students;

  Profile({
    required this.pk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePk,
    required this.gender,
    required this.isNewUser,
    this.profilePhoto,
    this.students,
  });

  factory Profile.empty() {
    return Profile(
      pk: '',
      username: '',
      firstName: '',
      lastName: '',
      email: '',
      profilePk: '',
      gender: '',
      isNewUser: false,
      students: [],
    );
  }

  Profile copyWith({
    String? pk,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePk,
    String? profilePhoto,
    String? gender,
    bool? isNewUser,
  }) {
    return Profile(
      pk: pk ?? this.pk,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePk: profilePk ?? this.profilePk,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      gender: gender ?? this.gender,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePk': profilePk,
      'profilePhoto': profilePhoto,
      'gender': gender,
      'isNewUser': isNewUser,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    final studentList = map['students'];
    List<Student> parsedStudents = [];
    if (studentList != null) {
      if (studentList.isNotEmpty) {
        for (var element in studentList) {
          final response = Student.fromMap(
            element as Map<String, dynamic>,
          );
          parsedStudents.add(response);
        }
      }
    }

    return Profile(
      pk: map['pk'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      profilePk: map['profilePk'] as String,
      profilePhoto: map['profilePhoto'] ?? '',
      gender: map['gender'] ?? '',
      isNewUser: map['is_new_user'] as bool,
      students: parsedStudents,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(pk: $pk, username: $username, gender: $gender, firstName: $firstName, lastName: $lastName, email: $email, profilePk: $profilePk, profilePhoto: $profilePhoto, isNewUser: $isNewUser)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.gender == gender &&
        other.profilePk == profilePk &&
        other.profilePhoto == profilePhoto &&
        other.isNewUser == isNewUser;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        profilePk.hashCode ^
        profilePhoto.hashCode ^
        isNewUser.hashCode;
  }
}
