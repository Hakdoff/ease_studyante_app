import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/core/common_widget/gpa_tile_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/assessment/domain/assessment_model.dart';
import 'package:ease_studyante_app/src/attendance/data/repository/attendance_repository.dart';
import 'package:ease_studyante_app/src/attendance/data/repository/attendance_repository_impl.dart';
import 'package:ease_studyante_app/src/attendance/presentation/blocs/bloc/attendance_bloc.dart';
import 'package:ease_studyante_app/src/attendance/presentation/pages/attendance_screen.dart';
import 'package:ease_studyante_app/src/grades/domain/model/student_overall_grade_model.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/grading_item_widget.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/subject_detail/bloc/subject_detail_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SubjectDetailScreen extends StatefulWidget {
  final SubjectModel subject;
  final Section section;
  final bool isTeacher;
  final bool isParent;
  final String studentId;
  final Student? selectedStudent;

  const SubjectDetailScreen({
    super.key,
    required this.subject,
    required this.section,
    required this.isTeacher,
    required this.isParent,
    required this.studentId,
    this.selectedStudent,
  });

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  late SubjectDetailBloc subjectDetailBloc;
  late GlobalBloc globalBloc;
  ValueNotifier<List<AssessmentModel>> gradingList = ValueNotifier([]);
  List<String> tempList = [];
  @override
  void initState() {
    super.initState();
    globalBloc = BlocProvider.of<GlobalBloc>(context);
    subjectDetailBloc = BlocProvider.of<SubjectDetailBloc>(context);
    if (widget.isTeacher) {
      subjectDetailBloc.add(
        GetAssessmentTeacherEvent(studentId: widget.studentId),
      );
      subjectDetailBloc.add(
        GetStudentTeacherOverallGrade(
          subjectId: widget.subject.id,
          studentId: widget.studentId,
        ),
      );
    } else if (widget.isParent) {
      subjectDetailBloc.add(
        GetAssessmentEvent(
          subjectId: widget.subject.id,
          isParent: widget.isParent,
          studentId: widget.studentId,
        ),
      );
      subjectDetailBloc.add(
        GetStudentOverallGrade(
          subjectId: widget.subject.id,
          isParent: widget.isParent,
          studentId: widget.studentId,
        ),
      );
    } else {
      subjectDetailBloc.add(
        GetAssessmentEvent(
          subjectId: widget.subject.id,
          isParent: widget.isParent,
        ),
      );
      subjectDetailBloc.add(
        GetStudentOverallGrade(
          subjectId: widget.subject.id,
          isParent: widget.isParent,
        ),
      );
    }

    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  double getListViewHeight(StudentOverallGradeModel gradeModel) {
    double height = 0;

    if (gradeModel.isViewGrade) {
      if (gradeModel.firstGrading != 'N/A') {
        height += 110;
      }
      if (gradeModel.secondGrading != 'N/A') {
        height += 110;
      }
      if (gradeModel.thirdGrading != 'N/A') {
        height += 110;
      }
      if (gradeModel.fourthGrading != 'N/A') {
        height += 110;
      }

      if (gradeModel.totalGpa != 'N/A') {
        height += 30;
      }
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subject.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorName.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<SubjectDetailBloc, SubjectDetailState>(
        bloc: subjectDetailBloc,
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.successful) {
            for (var element in state.assessment) {
              if (element.assessment.subject.code == widget.subject.code) {
                if (!tempList.contains(element.assessment.gradingPeriod)) {
                  tempList.add(element.assessment.gradingPeriod);
                  gradingList.value.add(element);
                }
              }
            }
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SpacedColumn(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: SpacedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subject Code: ${widget.subject.code}',
                          ),
                          Text(
                            'Department: ${widget.subject.department.name}',
                          ),
                          Text(
                            'Department code: ${widget.subject.department.code}',
                          ),
                          Text(
                            'Year Level: ${widget.subject.yearLevel}',
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: SpacedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.isParent || widget.isTeacher) ...[
                            Text(
                              'Name: ${widget.selectedStudent?.user.firstName} ${widget.selectedStudent?.user.lastName}',
                            ),
                          ] else ...[
                            Text(
                              'Name: ${globalBloc.state.studentProfile.firstName} ${globalBloc.state.studentProfile.lastName}',
                            ),
                          ],
                          Text(
                            'Section: ${widget.section.name}',
                          )
                        ],
                      ),
                    ),
                  ),
                  if (state.studentOverallGrade.isViewGrade &&
                      state.studentOverallGrade.totalGpa != 'N/A') ...[
                    GpaTileWidget(
                      title: 'GPA',
                      gpa: state.studentOverallGrade.totalGpa ?? '',
                    ),
                  ],
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 250),
                          type: PageTransitionType.fade,
                          child: RepositoryProvider<AttendanceRepository>(
                            create: (context) => AttendanceRepositoryImpl(),
                            child: BlocProvider<AttendanceBloc>(
                              create: (context) => AttendanceBloc(
                                attendanceRepository:
                                    RepositoryProvider.of<AttendanceRepository>(
                                        context),
                              ),
                              child: widget.isParent
                                  ? AttendanceScreen(
                                      subject: widget.subject,
                                      isParent: widget.isParent,
                                      studentId: widget.studentId,
                                    )
                                  : AttendanceScreen(
                                      subject: widget.subject,
                                      isParent: widget.isParent,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorName.primary,
                    ),
                    child: const Text(
                      'View Attendance',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (state.studentOverallGrade.isViewGrade) ...[
                    const Divider(
                      thickness: 3,
                    ),
                    ValueListenableBuilder(
                      valueListenable: gradingList,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: getListViewHeight(state.studentOverallGrade),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: GradingItemWidget(
                                  assessment: value[index],
                                  subjectDetailBloc: subjectDetailBloc,
                                  subject: widget.subject,
                                  studentGrade: state.studentOverallGrade,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: value.length,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
