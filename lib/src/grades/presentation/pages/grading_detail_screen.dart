import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/extensions/string_extension.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/assessment/domain/assessment_model.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/component_item_tile_widget.dart';
import 'package:ease_studyante_app/src/grades/presentation/pages/widgets/grading_component_tile_widget.dart';
import 'package:ease_studyante_app/core/common_widget/gpa_tile_widget.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/subject/presentation/blocs/subject_detail/bloc/subject_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradingDetailScreen extends StatefulWidget {
  final AssessmentModel assessment;
  final String gradingPeriodTitle;
  final SubjectDetailBloc subjectDetailBloc;
  final SubjectModel subject;

  const GradingDetailScreen({
    super.key,
    required this.assessment,
    required this.gradingPeriodTitle,
    required this.subjectDetailBloc,
    required this.subject,
  });

  @override
  State<GradingDetailScreen> createState() => _GradingDetailScreenState();
}

class _GradingDetailScreenState extends State<GradingDetailScreen> {
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

        final gradingPeriod =
            widget.assessment.assessment.gradingPeriod.split('_');
        String gradingPeriodTitle = '';

        for (var element in gradingPeriod) {
          gradingPeriodTitle += '${element.capitalize()} ';
        }

        String gpa = '';

        switch (widget.assessment.assessment.gradingPeriod) {
          case 'FIRST_GRADING':
            gpa = state.studentOverallGrade.firstGrading;
            break;
          case 'SECOND_GRADING':
            gpa = state.studentOverallGrade.secondGrading;
            break;
          case 'THIRD_GRADING':
            gpa = state.studentOverallGrade.thirdGrading;
            break;
          case 'FOURTH_GRADING':
            gpa = state.studentOverallGrade.fourthGrading;
            break;
          default:
        }

        for (var element in state.assessment) {
          if (widget.assessment.assessment.subject.code ==
                  element.assessment.subject.code &&
              widget.assessment.assessment.gradingPeriod ==
                  element.assessment.gradingPeriod) {
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
                  GpaTileWidget(
                    title: gradingPeriodTitle,
                    gpa: gpa,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  Visibility(
                    visible: assignmentComponent.isNotEmpty,
                    child: GradingComponentTileWidget(
                      componentTitle: 'Written Works',
                      componentItems: assignmentComponent,
                    ),
                  ),
                  Visibility(
                    visible: quizComponent.isNotEmpty,
                    child: GradingComponentTileWidget(
                      componentTitle: 'Performance Tasks',
                      componentItems: quizComponent,
                    ),
                  ),
                  Visibility(
                    visible: examComponent.isNotEmpty,
                    child: GradingComponentTileWidget(
                      componentTitle: 'Quarterly Assessments',
                      componentItems: examComponent,
                    ),
                  ),
                  Visibility(
                    visible: projectComponent.isNotEmpty,
                    child: GradingComponentTileWidget(
                      componentTitle: 'Projects',
                      componentItems: projectComponent,
                    ),
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
