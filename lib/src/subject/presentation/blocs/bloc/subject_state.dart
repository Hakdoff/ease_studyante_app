part of 'subject_bloc.dart';

class SubjectState extends Equatable {
  final ViewStatus viewStatus;
  final List<ScheduleModel> schedule;

  const SubjectState({
    required this.viewStatus,
    required this.schedule,
  });

  SubjectState copyWith({
    ViewStatus? viewStatus,
    List<ScheduleModel>? schedule,
  }) {
    return SubjectState(
      viewStatus: viewStatus ?? this.viewStatus,
      schedule: schedule ?? this.schedule,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        schedule,
      ];
}

final class SubjectInitial extends SubjectState {
  const SubjectInitial({
    required super.schedule,
    required super.viewStatus,
  });
}
