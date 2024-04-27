import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/user.dart';

class AttendanceStudentTimeOutItemModel {
  final String pk;
  final User user;
  final String address;
  final String contactNumber;
  final int age;
  final String gender;
  final String yearLevel;
  final String qr;

  AttendanceStudentTimeOutItemModel({
    required this.pk,
    required this.user,
    required this.address,
    required this.contactNumber,
    required this.age,
    required this.gender,
    required this.yearLevel,
    required this.qr,
  });

  factory AttendanceStudentTimeOutItemModel.fromMap(Map<String, dynamic> map) {
    return AttendanceStudentTimeOutItemModel(
      pk: map['pk'] ?? '',
      user: User.fromMap(
        map['user'] as Map<String, dynamic>,
      ),
      address: map['address'] ?? '',
      contactNumber: map['contact_number'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      yearLevel: map['year_level'] ?? '',
      qr: map['qr_code_photo'] ?? '',
    );
  }

  factory AttendanceStudentTimeOutItemModel.empty() {
    return AttendanceStudentTimeOutItemModel(
      pk: '',
      user: User.empty(),
      address: '',
      contactNumber: '',
      age: 0,
      gender: '',
      yearLevel: '',
      qr: '',
    );
  }
}
