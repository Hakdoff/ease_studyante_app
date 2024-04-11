import 'package:ease_studyante_app/core/extensions/time_formatter.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';

class TeacherSubjectCard extends StatelessWidget {
  const TeacherSubjectCard({
    Key? key,
    required this.schedule,
    required this.onTap,
  }) : super(key: key);

  final TeacherSchedule schedule;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: ColorName.background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: schedule.subject.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                CustomText(
                  text:
                      '${schedule.section.yearLevel} - ${schedule.section.name}',
                ),
                CustomText(
                  text:
                      '${schedule.timeStart.parseStrToTime()} - ${schedule.timeEnd.parseStrToTime()}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
