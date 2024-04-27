import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/common_widget/spaced_row_widget.dart';
import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceItemWidget extends StatelessWidget {
  final StudentAttendanceModel studentAttendance;
  const AttendanceItemWidget({
    super.key,
    required this.studentAttendance,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    String formattedTime = '';
    final timeIn = studentAttendance.timeIn;

    if (timeIn != null) {
      formattedDate = DateFormat.yMMMMd('en_US').format(
        DateTime.parse(
          timeIn,
        ),
      );

      formattedTime = DateFormat.jm().format(
        DateTime.parse(
          timeIn,
        ).add(
          const Duration(
            hours: 8,
          ),
        ),
      );
    }
    final status = studentAttendance.timeIn == null
        ? "Absent"
        : studentAttendance.isPresent
            ? 'Present'
            : 'Tardy';
    final statusColor =
        status != 'Present' ? Colors.red[400] : Colors.green[400];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      child: SpacedColumn(
        spacing: 20,
        children: [
          SpacedRow(
            children: [
              Text(
                studentAttendance.student.user.fullName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                'Date: ${studentAttendance.attendanceDate}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SpacedRow(
            children: [
              Row(
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (timeIn != null) ...[
                Text(
                  'Time In: $formattedTime',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
