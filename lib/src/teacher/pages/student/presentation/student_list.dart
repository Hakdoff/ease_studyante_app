import 'package:ease_studyante_app/core/common_widget/custom_appbar.dart';
import 'package:ease_studyante_app/core/common_widget/custom_text.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/bloc/student_list_bloc.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/presentation/widgets/student_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentListArgs {
  final TeacherSchedule schedule;
  final String appbarTitle;

  StudentListArgs({
    required this.schedule,
    required this.appbarTitle,
  });
}

class StudentListPage extends StatefulWidget {
  static const String routeName = 'teacher/student/list';
  final StudentListArgs args;

  const StudentListPage({super.key, required this.args});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final ScrollController scrollController = ScrollController();
  late StudentListBloc studentListBloc;

  @override
  void initState() {
    super.initState();
    studentListBloc = BlocProvider.of<StudentListBloc>(context);
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: widget.args.appbarTitle),
      body: BlocBuilder<StudentListBloc, StudentListState>(
        builder: (context, state) {
          if (state is StudentListError) {
            return Center(
              child: CustomText(text: state.errorMessage),
            );
          }
          if (state is StudentListLoaded) {
            return StudentListView(
              scrollController: scrollController,
              isPaginate: state.isPaginate,
              students: state.studentList.students,
              schedule: widget.args.schedule,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void initBloc() {
    studentListBloc
        .add(OnGetTeacherStudentList(section: widget.args.schedule.section.id));
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        BlocProvider.of<StudentListBloc>(context).add(
            OnPaginateTeacherStudentList(
                section: widget.args.schedule.section.id));
      }
    });
  }
}
