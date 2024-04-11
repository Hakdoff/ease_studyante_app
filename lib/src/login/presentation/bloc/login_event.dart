part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnSubmitLoginEvent extends LoginEvent {
  final String emailAddress;
  final String password;
  final bool isStudent;
  final bool isTeacher;
  final bool isParent;

  const OnSubmitLoginEvent({
    required this.emailAddress,
    required this.password,
    this.isStudent = false,
    this.isTeacher = false,
    this.isParent = false,
  });

  @override
  List<Object> get props => [
        emailAddress,
        password,
        isStudent,
        isTeacher,
        isParent,
      ];
}
