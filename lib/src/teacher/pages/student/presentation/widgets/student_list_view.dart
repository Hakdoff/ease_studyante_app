import 'package:ease_studyante_app/core/common_widget/common_dialog.dart';
import 'package:ease_studyante_app/core/common_widget/custom_btn.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/data/data_sources/qr_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/domain/repositories/qr_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/presentation/bloc/qr_code_scanner_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/bloc/student_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/student_detail.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({
    super.key,
    required this.scrollController,
    required this.isPaginate,
    required this.students,
    required this.schedule,
    required this.bloc,
  });

  final ScrollController scrollController;
  final bool isPaginate;
  final List<Student> students;
  final TeacherSchedule schedule;
  final StudentListBloc bloc;

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  bool isAddedToList = false;
  List<String> studentIds = [];

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<QRRepository>(
      create: (context) => QRRepositoryImpl(),
      child: BlocProvider<QrCodeScannerBloc>(
        create: (context) =>
            QrCodeScannerBloc(RepositoryProvider.of<QRRepository>(context)),
        child: BlocConsumer<StudentListBloc, StudentListState>(
          bloc: widget.bloc,
          listener: (context, state) {
            if (state is PostStudentTimeOutSuccessState) {
              CommonDialog.showMyDialog(
                context: context,
                body: 'Timeout Recorded',
              ).then(
                (value) => Navigator.pop(context),
              );
            }
          },
          builder: (context, state) {
            if (state is StudentListLoaded) {
              return Column(
                children: [
                  const Gap(10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.studentList.students.length,
                      itemBuilder: (context, index) {
                        final item = state.studentList.students[index];
                        final isAdded = studentIds.contains(item.user.pk);

                        return Row(
                          children: [
                            Expanded(
                              child: StudentCard(
                                student: item,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      type: PageTransitionType.fade,
                                      child: RepositoryProvider<QRRepository>(
                                        create: (context) => QRRepositoryImpl(),
                                        child: BlocProvider<QrCodeScannerBloc>(
                                          create: (context) =>
                                              QrCodeScannerBloc(
                                            RepositoryProvider.of<QRRepository>(
                                                context),
                                          ),
                                          child: StudentDetailPage(
                                            schedule: widget.schedule,
                                            student: item,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Checkbox(
                              value: isAdded,
                              activeColor: ColorName.primary,
                              onChanged: (value) {
                                setState(() {
                                  final temp = value;
                                  isAddedToList =
                                      studentIds.contains(item.user.pk);

                                  if (temp != null) {
                                    !isAddedToList
                                        ? studentIds.add(item.user.pk)
                                        : studentIds.removeWhere(
                                            (element) =>
                                                element == item.user.pk,
                                          );
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomBtn(
                      label: 'Time out Student/s',
                      onTap: studentIds.isNotEmpty
                          ? () {
                              List<String> finalList = [];
                              for (var element in studentIds) {
                                final result = state.studentTimeOut
                                    .where((e) => e.student.user.pk == element);
                                if (result.isNotEmpty) {
                                  finalList.add(result.first.student.pk);
                                }
                              }
                              widget.bloc.add(
                                PostStudentAttendanceTimeout(
                                  section: widget.schedule.id,
                                  studentIds: finalList,
                                ),
                              );
                              print(finalList);
                            }
                          : null,
                    ),
                  ),
                ],
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
