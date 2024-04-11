import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/assessment/domain/assessment_model.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/component_item_tile_widget.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/grading_component_tile_widget.dart';
import 'package:ease_studyante_app/core/common_widget/gpa_tile_widget.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/subject_detail/bloc/subject_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentGradeDetailScreen extends StatefulWidget {
  final AssessmentModel assessment;
  final String gradingPeriodTitle;
  final SubjectDetailBloc subjectDetailBloc;
  final SubjectModel subject;

  const StudentGradeDetailScreen({
    super.key,
    required this.assessment,
    required this.gradingPeriodTitle,
    required this.subjectDetailBloc,
    required this.subject,
  });

  @override
  State<StudentGradeDetailScreen> createState() =>
      _StudentGradeDetailScreenState();
}

class _StudentGradeDetailScreenState extends State<StudentGradeDetailScreen> {
  late SubjectDetailBloc subjectDetailBloc;

  @override
  void initState() {
    super.initState();
    subjectDetailBloc = widget.subjectDetailBloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectDetailBloc, SubjectDetailState>(
      bloc: subjectDetailBloc,
      builder: (context, state) {
        List<ComponentItemTileWidget> quizComponent = [];
        List<ComponentItemTileWidget> examComponent = [];
        List<ComponentItemTileWidget> assignmentComponent = [];
        List<ComponentItemTileWidget> projectComponent = [];

        for (var element in state.assessment) {
          if (widget.assessment.assessment.subject.code ==
              element.assessment.subject.code) {
            final finalGrade =
                '${double.parse(element.obtainedMarks).toStringAsFixed(0)} / ${double.parse(element.assessment.maxMark).toStringAsFixed(0)}';
            final component = ComponentItemTileWidget(
              componentItemName: element.assessment.name,
              grade: finalGrade,
            );
            switch (element.assessment.taskType) {
              case 'QUIZ':
                quizComponent.add(component);
                break;
              case 'PROJECT':
                projectComponent.add(component);
                break;
              case 'EXAM':
                examComponent.add(component);
                break;
              case 'ASSIGNMENT':
                assignmentComponent.add(component);
                break;
              default:
                break;
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.gradingPeriodTitle,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: ColorName.primary,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SpacedColumn(
                spacing: 20,
                children: [
                  const GpaTileWidget(
                    title: 'First Grading',
                    gpa: '1.23',
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  GradingComponentTileWidget(
                    componentTitle: 'Assignment',
                    componentItems: assignmentComponent,
                  ),
                  GradingComponentTileWidget(
                    componentTitle: 'Quiz',
                    componentItems: quizComponent,
                  ),
                  GradingComponentTileWidget(
                    componentTitle: 'Exam',
                    componentItems: examComponent,
                  ),
                  GradingComponentTileWidget(
                    componentTitle: 'Projects',
                    componentItems: projectComponent,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
