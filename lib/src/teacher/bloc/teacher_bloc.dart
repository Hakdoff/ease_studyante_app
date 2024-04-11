import 'package:ease_studyante_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/domain/entities/teacher.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/domain/repositories/teacher_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final TeacherProfileRepository repository;

  TeacherBloc(this.repository) : super(TeacherInitial()) {
    on<OnGetTeacherProfileEvent>(onGetTeacherProfileEvent);
    on<SetTeacherProfileEvent>(setTeacherProfileEvent);
    on<OnTeacherLogout>(onTeacherLogout);
  }

  void onTeacherLogout(OnTeacherLogout event, Emitter<TeacherState> emit) {
    emit(TeacherLogout());
  }

  Future<void> onGetTeacherProfileEvent(
      OnGetTeacherProfileEvent event, Emitter<TeacherState> emit) async {
    try {
      emit(TeacherLoading());

      final response = await repository.getTeacherProfile();
      await LocalStorage.storeLocalStorage('_teacher', response.toString());

      emit(TeacherLoaded(teacher: response));
    } catch (e) {
      emit(TeacherError(errorMessage: e.toString()));
    }
  }

  Future<void> setTeacherProfileEvent(
      SetTeacherProfileEvent event, Emitter<TeacherState> emit) async {
    final user = await LocalStorage.readLocalStorage('_teacher');
    if (user != null) {
      final response = await repository.getTeacherProfile();
      emit(TeacherLoaded(teacher: response));
      // await registerFcmToken();
      return;
    } else {
      await LocalStorage.deleteLocalStorage('_teacher');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
    }
    return emit(TeacherInitial());
  }
}
