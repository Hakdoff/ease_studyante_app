import 'dart:async';
import 'dart:convert';

import 'package:ease_studyante_app/core/local_storage/local_storage.dart';
import 'package:ease_studyante_app/src/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<SetProfileEvent>(_setProfile);
    on<SetProfileLogoutEvent>(_setProfileLogoutEvent);
    on<SetProfilePicture>(_setProfilePicture);
    on<OnGetProfileEvent>(_onGetProfileEvent);
    on<OnGetStudentProfileEvent>(_onGetStudentProfileEvent);
  }

  Future<void> _setProfile(
      SetProfileEvent event, Emitter<ProfileState> emit) async {
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final response = await repository.getUserProfile();
      emit(ProfileLoaded(profile: response));
      // await registerFcmToken();
      return;
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      await LocalStorage.deleteLocalStorage('_whiteList');
    }
    return emit(ProfileInitial());
  }

  void _setProfileLogoutEvent(
      SetProfileLogoutEvent event, Emitter<ProfileState> emit) async {
    return emit(ProfileLogout());
  }

  void _setProfilePicture(SetProfilePicture event, Emitter<ProfileState> emit) {
    final state = this.state;

    if (state is ProfileLoaded) {
      return emit(
        ProfileLoaded(
          profile: state.profile.copyWith(profilePhoto: event.profilePhoto),
        ),
      );
    }
  }

  void _onGetProfileEvent(
      OnGetProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      final response = await repository.getUserProfile();
      await LocalStorage.storeLocalStorage('_user', response.toString());

      emit(ProfileLoaded(profile: response));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onGetStudentProfileEvent(
    OnGetStudentProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());

      final response = await repository.getStudentProfile();
      await LocalStorage.storeLocalStorage(
        '_studentProfile',
        response.toString(),
      );

      emit(
        ProfileLoaded(
          profile: response,
        ),
      );
    } catch (e) {
      emit(
        ProfileError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
