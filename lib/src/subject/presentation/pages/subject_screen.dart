import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/subject_item_widget.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/bloc/subject_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectScreen extends StatefulWidget {
  final bool isParent;
  const SubjectScreen({
    super.key,
    required this.isParent,
  });

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late SubjectBloc subjectBloc;
  late GlobalBloc globalBloc;
  ValueNotifier<bool> isParentScreenPresent = ValueNotifier(true);
  ValueNotifier<Student?> selectedStudent = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    subjectBloc = BlocProvider.of<SubjectBloc>(context);
    globalBloc = BlocProvider.of<GlobalBloc>(context);
    if (!widget.isParent) {
      subjectBloc.add(
        GetStudentSchedule(
          isParent: widget.isParent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SubjectBloc, SubjectState>(
          listener: (context, state) {
            if (state.viewStatus == ViewStatus.successful) {
              globalBloc.add(
                StoreStudentSectionEvent(
                  section: state.schedule[0].section,
                ),
              );
              globalBloc.add(
                StoreStudentScheduleEvent(
                  schedule: state.schedule,
                ),
              );
            }
          },
          builder: (context, state) {
            return state.viewStatus == ViewStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ValueListenableBuilder(
                    valueListenable: isParentScreenPresent,
                    builder: (context, value, child) {
                      return getBodyWidget(
                        state: state,
                        isParentScreen: value,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  Widget getBodyWidget({
    required SubjectState state,
    required bool isParentScreen,
  }) {
    final students = globalBloc.state.studentProfile.students;
    if (widget.isParent && students != null && isParentScreen) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SpacedColumn(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Students',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: students.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedStudent.value = students[index];
                      subjectBloc.add(
                        GetStudentSchedule(
                          isParent: widget.isParent,
                          studentId: students[index].pk,
                        ),
                      );
                      isParentScreenPresent.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: ColorName.dimGray.withOpacity(
                            0.5,
                          ),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${students[index].user.firstName} ${students[index].user.lastName}',
                          ),
                          Text(
                            'Email: ${students[index].user.email}',
                          ),
                          if (widget.isParent) ...[
                            Text(
                              'Learner Reference Number: ${students[index].lrn}',
                            ),
                          ] else ...[
                            ValueListenableBuilder(
                              valueListenable: selectedStudent,
                              builder: (context, currentStudent, child) {
                                final lrn = currentStudent?.lrn ?? '';
                                return Text(
                                  'Learner Reference Number: $lrn',
                                );
                              },
                            ),
                          ],
                          Text(
                            'Grade: ${students[index].yearLevel}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return ValueListenableBuilder(
      valueListenable: selectedStudent,
      builder: (context, student, child) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SpacedColumn(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Subjects',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.schedule.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return SubjectItemWidget(
                      subject: state.schedule[index].subject,
                      section: state.schedule[index].section,
                      schedule: state.schedule[index],
                      isParent: widget.isParent,
                      selectedStudent: student,
                      onStudentSubjectTapped: () {
                        isParentScreenPresent.value = true;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
