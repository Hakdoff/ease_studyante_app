import 'package:ease_studyante_app/src/profile/data/data_sources/profile_repository_impl.dart';
import 'package:ease_studyante_app/src/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  final ProfileRepository profileRepository;

  LoginBloc(this.repository, this.profileRepository) : super(LoginInitial()) {
    on<OnSubmitLoginEvent>(onSubmitLoginEvent);
  }

  Future<void> onSubmitLoginEvent(
    OnSubmitLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());

      final response = await repository.login(
        email: event.emailAddress,
        password: event.password,
        isParent: event.isParent,
        isStudent: event.isStudent,
        isTeacher: event.isTeacher,
      );

      await repository.saveTokens(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
      );

      final token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        await ProfileRepositoryImpl().setPushToken(token);
      }

      emit(LoginSuccess());
    } catch (e) {
      final dynamic error = e;
      emit(LoginError(error['data']['error_description']));
    }
  }
}
