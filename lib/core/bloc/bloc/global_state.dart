part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final ViewStatus viewStatus;
  final Profile studentProfile;
  final Section studentSection;
  final List<ScheduleModel> studentSchedule;

  const GlobalState({
    required this.viewStatus,
    required this.studentProfile,
    required this.studentSection,
    required this.studentSchedule,
  });

  GlobalState copyWith({
    ViewStatus? viewStatus,
    Profile? studentProfile,
    Section? studentSection,
    List<ScheduleModel>? studentSchedule,
  }) {
    return GlobalState(
      viewStatus: viewStatus ?? this.viewStatus,
      studentProfile: studentProfile ?? this.studentProfile,
      studentSection: studentSection ?? this.studentSection,
      studentSchedule: studentSchedule ?? this.studentSchedule,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        studentProfile,
        studentSection,
        studentSchedule,
      ];
}

final class GlobalInitial extends GlobalState {
  const GlobalInitial({
    required super.viewStatus,
    required super.studentProfile,
    required super.studentSection,
    required super.studentSchedule,
  });
}
