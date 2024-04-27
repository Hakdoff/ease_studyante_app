class AttendanceTimeoutItemModel {
  final String pk;
  final String timeIn;
  final String timeOut;
  final bool isPresent;
  final String attendanceDate;

  AttendanceTimeoutItemModel({
    required this.pk,
    required this.isPresent,
    required this.attendanceDate,
    required this.timeIn,
    required this.timeOut,
  });

  factory AttendanceTimeoutItemModel.fromMap(Map<String, dynamic> map) {
    return AttendanceTimeoutItemModel(
      pk: map['pk'] ?? '',
      timeIn: map['time_in'] ?? '',
      timeOut: map['time_out'] ?? '',
      isPresent: map['is_present'] ?? '',
      attendanceDate: map['attendance_date'] ?? '',
    );
  }

  factory AttendanceTimeoutItemModel.empty() {
    return AttendanceTimeoutItemModel(
      pk: '',
      isPresent: false,
      attendanceDate: '',
      timeIn: '',
      timeOut: '',
    );
  }
}
