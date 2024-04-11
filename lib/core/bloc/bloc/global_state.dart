part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final ViewStatus viewStatus;
  final Profile studentProfile;
  final Section studentSection;

  const GlobalState({
    required this.viewStatus,
    required this.studentProfile,
    required this.studentSection,
  });

  GlobalState copyWith({
    ViewStatus? viewStatus,
    Profile? studentProfile,
    Section? studentSection,
  }) {
    return GlobalState(
      viewStatus: viewStatus ?? this.viewStatus,
      studentProfile: studentProfile ?? this.studentProfile,
      studentSection: studentSection ?? this.studentSection,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        studentProfile,
        studentSection,
      ];
}

final class GlobalInitial extends GlobalState {
  const GlobalInitial({
    required super.viewStatus,
    required super.studentProfile,
    required super.studentSection,
  });
}
