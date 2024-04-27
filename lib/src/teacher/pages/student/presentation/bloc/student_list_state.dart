part of 'student_list_bloc.dart';

abstract class StudentListState extends Equatable {
  const StudentListState();

  @override
  List<Object> get props => [];
}

class StudentListInitial extends StudentListState {}

class StudentListError extends StudentListState {
  final String errorMessage;

  const StudentListError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StudentListLoading extends StudentListState {}

class PostStudentTimeOutSuccessState extends StudentListState {}

class StudentListLoaded extends StudentListState {
  final StudentListResponseModel studentList;
  final List<AttendanceTimeOutModel> studentTimeOut;
  final bool isPaginate;

  const StudentListLoaded({
    required this.studentList,
    required this.studentTimeOut,
    this.isPaginate = false,
  });

  StudentListLoaded copyWith({
    StudentListResponseModel? studentList,
    bool? isPaginate,
    List<AttendanceTimeOutModel>? studentTimeOut,
  }) {
    return StudentListLoaded(
      studentList: studentList ?? this.studentList,
      isPaginate: isPaginate ?? this.isPaginate,
      studentTimeOut: studentTimeOut ?? this.studentTimeOut,
    );
  }

  @override
  List<Object> get props => [
        studentList,
        isPaginate,
      ];
}
