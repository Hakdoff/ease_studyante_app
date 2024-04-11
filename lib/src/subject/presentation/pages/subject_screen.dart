import 'package:ease_studyante_app/core/bloc/bloc/global_bloc.dart';
import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/subject_item_widget.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/bloc/subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late SubjectBloc subjectBloc;
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();
    subjectBloc = BlocProvider.of<SubjectBloc>(context);
    subjectBloc.add(GetStudentSchedule());
    globalBloc = BlocProvider.of<GlobalBloc>(context);
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
            }
          },
          builder: (context, state) {
            return state.viewStatus == ViewStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
