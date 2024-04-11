import 'package:ease_studyante_app/core/common_widget/shimmer.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_app/src/teacher/pages/schedule/presentation/widgets/teacher_subject_card.dart';
import 'package:flutter/material.dart';

class TeacherScheduleListLoading extends StatelessWidget {
  const TeacherScheduleListLoading({
    Key? key,
    this.itemCount,
  }) : super(key: key);

  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount ?? 15,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer(
          linearGradient: AppConstant.shimmerGradient,
          child: ShimmerLoading(
            isLoading: true,
            child: TeacherSubjectCard(
              schedule: TeacherSchedule.empty(),
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
