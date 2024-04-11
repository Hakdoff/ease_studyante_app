import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final dynamic data;
  final String status;

  const LoginResponse({
    required this.data,
    required this.status,
  });

  @override
  List<Object?> get props => [
        data,
        status,
      ];
}
