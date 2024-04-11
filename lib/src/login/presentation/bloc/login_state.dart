part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;

  const LoginError(this.errorMessage);

  @override
  List<Object> get props => [];
}
