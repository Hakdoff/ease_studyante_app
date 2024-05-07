import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/assessment/data/repository/assessment_repository.dart';
import 'package:ease_studyante_app/src/assessment/data/repository/assessment_repository_impl.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/subject_detail/bloc/subject_detail_bloc.dart';
import 'package:ease_studyante_app/src/subject/presentation/pages/subject_detail_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/presentation/blocs/bloc/teacher_attendance_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/presentation/pages/attendance_screen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/presentation/bloc/qr_code_scanner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';

import '../../attendance/data/repository/teacher_attendance_repository.dart';

class StudentDetailArgs {
  final TeacherSchedule schedule;
  final Student student;

  StudentDetailArgs({
    required this.schedule,
    required this.student,
  });
}

class StudentDetailPage extends StatefulWidget {
  static const String routeName = 'teacher/student/detail';
  final TeacherSchedule schedule;
  final Student student;

  const StudentDetailPage({
    super.key,
    required this.schedule,
    required this.student,
  });

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  late Student student;
  late Section section;

  late QrCodeScannerBloc bloc;
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();
    student = widget.student;
    section = widget.schedule.section;
    bloc = BlocProvider.of<QrCodeScannerBloc>(context);
    globalBloc = BlocProvider.of<GlobalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrCodeScannerBloc, QrCodeScannerState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is QrCodeErrorState) {
          CommonDialog.showMyDialog(
            context: context,
            body: state.errorMessage,
          );
        }

        if (state is QrCodeScannerLoaded) {
          CommonDialog.showMyDialog(
            context: context,
            body: state.errorMessage != null
                ? state.errorMessage ?? ''
                : 'Attendance Recorded',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context: context, title: 'Student Detail'),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .17,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .10,
                      decoration: const BoxDecoration(
                        color: ColorName.primary,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.03,
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 55,
                        child: CircleAvatar(
                          backgroundColor: ColorName.primary,
                          backgroundImage: student.profilePhoto != null
                              ? Image.network(student.profilePhoto!).image
                              : null,
                          radius: 50,
                          child: student.profilePhoto != null
                              ? null
                              : const Icon(
                                  Icons.person,
                                  size: 65,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomText(
                text: '${student.user.lastName}, ${student.user.firstName}'
                    .toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Student Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(
                            color: ColorName.primary,
                            thickness: 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                listTile(
                                    title: 'Email:', data: student.user.email),
                                listTile(title: 'Section:', data: section.name),
                                listTile(
                                    title: 'Year Level:',
                                    data: section.yearLevel),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomBtn(
                            label: 'Log Attendance',
                            onTap: () {
                              CommonDialog.showMyDialog(
                                context: context,
                                body: 'Is student present?',
                                buttons: [
                                  CustomBtn(
                                    label: 'Yes',
                                    onTap: () {
                                      try {
                                        bloc.add(
                                          OnQRScanEvent(
                                            id: widget.student.pk,
                                          ),
                                        );
                                      } catch (e) {
                                        // handle something went wrong
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomBtn(
                                    label: 'No',
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          ),
                          const Gap(10),
                          CustomBtn(
                            label: 'View Attendance',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: const Duration(milliseconds: 250),
                                  type: PageTransitionType.fade,
                                  child: RepositoryProvider<
                                      TeacherAttendanceRepository>(
                                    create: (context) =>
                                        TeacherAttendanceRepositoryImpl(),
                                    child: BlocProvider<TeacherAttendanceBloc>(
                                      create: (context) =>
                                          TeacherAttendanceBloc(
                                        attendanceRepository: RepositoryProvider
                                            .of<TeacherAttendanceRepository>(
                                                context),
                                      ),
                                      child: TeacherAttendanceScreen(
                                        subject: widget.schedule.subject,
                                        student: student,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Gap(10),
                          CustomBtn(
                            label: 'View Grades',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: const Duration(milliseconds: 250),
                                  type: PageTransitionType.fade,
                                  child:
                                      RepositoryProvider<AssessmentRepository>(
                                    create: (context) =>
                                        AssessmentRepositoryImpl(),
                                    child: BlocProvider<SubjectDetailBloc>(
                                      create: (context) => SubjectDetailBloc(
                                        assessmentRepository: RepositoryProvider
                                            .of<AssessmentRepository>(context),
                                      ),
                                      child: SubjectDetailScreen(
                                        subject: widget.schedule.subject,
                                        section: section,
                                        isTeacher: true,
                                        studentId: student.user.pk,
                                        isParent: false,
                                        selectedStudent: widget.student,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget listTile({
    required String title,
    required String data,
  }) {
    return Row(
      children: [
        CustomText(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        CustomText(text: data),
      ],
    );
  }
}
