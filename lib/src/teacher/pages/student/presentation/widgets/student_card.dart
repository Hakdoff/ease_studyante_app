import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudentCard extends StatefulWidget {
  const StudentCard({
    super.key,
    required this.student,
    required this.onTap,
  });

  final Student student;
  final VoidCallback onTap;

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
                          backgroundImage: widget.student.profilePhoto != null
                              ? Image.network(widget.student.profilePhoto!)
                                  .image
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
                              '${widget.student.user.lastName}, ${widget.student.user.firstName}',
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
