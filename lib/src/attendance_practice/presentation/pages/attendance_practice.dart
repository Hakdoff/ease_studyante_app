import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/bloc/attendance_practice_bloc.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/bloc/attendance_practice_event.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/bloc/attendance_practice_state.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/pages/widgets/attendance_item_practice.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePractice extends StatefulWidget {
  final SubjectModel subject;

  const AttendancePractice({
    super.key,
    required this.subject,
  });

  @override
  State<AttendancePractice> createState() => _AttendancePracticeState();
}

class _AttendancePracticeState extends State<AttendancePractice> {
  late AttendancePracticeBloc attendancepracticebloc;
  late GlobalBloc globalbloc;

  @override
  void initState() {
    super.initState();
    attendancepracticebloc = BlocProvider.of<AttendancePracticeBloc>(context);
    globalbloc = BlocProvider.of<GlobalBloc>(context);
    attendancepracticebloc
        .add(GetStudentAttendancePracticeEvent(subject: widget.subject));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorName.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<AttendancePracticeBloc, AttendancePracticeState>(
        bloc: attendancepracticebloc,
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context, index) => AttendanceItemPracticeWideget(
                studentAttendancePracticeModel:
                    state.studentAttendancePractice[index],
              ),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 3,
                ),
              ),
              itemCount: state.studentAttendancePractice.length,
            ),
          );
        },
      ),
    );
  }
}
