import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/common_widget/spaced_row_widget.dart';
import 'package:ease_studyante_app/src/attendance_practice/domain/models/student_attendance_practice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AttendanceItemPracticeWideget extends StatelessWidget {
  final StudentAttendancePraticeModel studentAttendancePracticeModel;

  const AttendanceItemPracticeWideget(
      {super.key, required this.studentAttendancePracticeModel});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd('en_US').format(
      DateTime.parse(
        studentAttendancePracticeModel.timeIn,
      ),
    );
    final formattedTime = DateFormat.Hms().format(DateTime.parse(
      studentAttendancePracticeModel.timeIn,
    ));
    final status =
        studentAttendancePracticeModel.isPresent ? 'Present' : 'Tardy';
    final statusColor = status != 'Present' ? Colors.orange : Colors.green[400];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SpacedColumn(
        spacing: 20,
        children: [
          SpacedRow(
            children: [
              Text(
                studentAttendancePracticeModel.student.user.fullName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                'Date: $formattedDate',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ],
          ),
          SpacedRow(
            children: [
              Row(
                children: [
                  const Text(
                    'Status:',
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
              Text(
                'Time In: $formattedTime',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
