import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/user.dart';

class Student extends Equatable {
  final User user;
  final String address;
  final String contactNumber;
  final int age;
  final String gender;
  final String lrn;
  final String yearLevel;
  final String? profilePhoto;
  final String pk;

  const Student({
    required this.user,
    required this.address,
    required this.contactNumber,
    required this.age,
    required this.gender,
    required this.lrn,
    required this.yearLevel,
    required this.pk,
    this.profilePhoto,
  });

  Student copyWith({
    User? user,
    String? address,
    String? contactNumber,
    int? age,
    String? gender,
    String? lrn,
    String? yearLevel,
    String? profilePhoto,
    String? pk,
  }) {
    return Student(
      pk: pk ?? this.pk,
      user: user ?? this.user,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      lrn: lrn ?? this.lrn,
      yearLevel: yearLevel ?? this.yearLevel,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      pk: map['pk'] ?? '',
      user: User.fromMap(map['user']),
      address: map['address'] ?? '',
      contactNumber: map['contact_number'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      lrn: map['lrn'] ?? '',
      yearLevel: map['year_level'] ?? '',
      profilePhoto: map['profile_photo'],
    );
  }

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(user: $user, address: $address, contactNumber: $contactNumber, age: $age, gender: $gender, lrn: $lrn, yearLevel: $yearLevel, profilePhoto: $profilePhoto)';
  }

  @override
  List<Object?> get props {
    return [
      user,
      address,
      contactNumber,
      age,
      gender,
      lrn,
      yearLevel,
      profilePhoto,
    ];
  }
}
