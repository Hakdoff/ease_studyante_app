import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/attendance/presentation/blocs/bloc/attendance_bloc.dart';
import 'package:ease_studyante_app/src/attendance/presentation/pages/widgets/attendance_item.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatefulWidget {
  final SubjectModel subject;

  const AttendanceScreen({
    super.key,
    required this.subject,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceBloc attendanceBloc;
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();
    attendanceBloc = BlocProvider.of<AttendanceBloc>(context);
    globalBloc = BlocProvider.of<GlobalBloc>(context);
    attendanceBloc.add(GetStudentAttendanceEvent(subject: widget.subject));
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
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        bloc: attendanceBloc,
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context, index) => AttendanceItemWidget(
                studentAttendance: state.studentAttendance[index],
              ),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(thickness: 3),
              ),
              itemCount: state.studentAttendance.length,
            ),
          );
        },
      ),
    );
  }
}
