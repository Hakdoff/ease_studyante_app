import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.student,
    required this.onTap,
  });

  final Student student;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorName.primary,
                          backgroundImage: student.profilePhoto != null
                              ? Image.network(student.profilePhoto!).image
                              : null,
                          radius: 20,
                          child: const Icon(
                            Icons.person,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(10),
                        CustomText(
                          text:
                              '${student.user.lastName}, ${student.user.firstName}',
                        )
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
