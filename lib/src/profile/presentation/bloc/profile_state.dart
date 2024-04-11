part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded({
    required this.profile,
  });

  ProfileLoaded copyWith({
    Profile? profile,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profile': profile.toMap(),
    };
  }

  factory ProfileLoaded.fromMap(Map<String, dynamic> map) {
    return ProfileLoaded(
      profile: map['profile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileLoaded.fromJson(String source) =>
      ProfileLoaded.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [profile];
}

class ProfileInitial extends ProfileState {}

class ProfileLogout extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  const ProfileError({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
