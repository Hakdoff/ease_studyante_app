import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/core/extensions/time_formatter.dart';
import 'package:ease_studyante_app/src/assessment/data/repository/assessment_repository.dart';
import 'package:ease_studyante_app/src/assessment/data/repository/assessment_repository_impl.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/subject_detail/bloc/subject_detail_bloc.dart';
import 'package:ease_studyante_app/src/subject/presentation/pages/subject_detail_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SubjectItemWidget extends StatelessWidget {
  final SubjectModel subject;
  final Section section;
  final ScheduleModel schedule;
  final bool isParent;
  final Student? selectedStudent;
  final Function()? onStudentSubjectTapped;

  const SubjectItemWidget({
    super.key,
    required this.subject,
    required this.section,
    required this.schedule,
    required this.isParent,
    this.selectedStudent,
    this.onStudentSubjectTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onStudentSubjectTapped!();
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 250),
            type: PageTransitionType.fade,
            child: RepositoryProvider<AssessmentRepository>(
              create: (context) => AssessmentRepositoryImpl(),
              child: BlocProvider<SubjectDetailBloc>(
                create: (context) => SubjectDetailBloc(
                  assessmentRepository:
                      RepositoryProvider.of<AssessmentRepository>(context),
                ),
                child: SubjectDetailScreen(
                  subject: subject,
                  section: section,
                  isTeacher: false,
                  studentId: selectedStudent?.pk ?? '',
                  isParent: isParent,
                  selectedStudent: selectedStudent,
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              CustomText(
                text: '${section.yearLevel} - ${section.name}',
              ),
              CustomText(
                text: schedule.days,
              ),
              CustomText(
                text:
                    '${schedule.timeStart.parseStrToTime()} - ${schedule.timeEnd.parseStrToTime()}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
