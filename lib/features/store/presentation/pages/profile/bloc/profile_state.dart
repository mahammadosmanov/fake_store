part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileInitialized extends ProfileState {
  const ProfileInitialized({
    required this.userName,
    required this.age,
    required this.editingUserName,
    required this.editingAge,
    required this.language,
  });

  final String userName;
  final String age;
  final bool editingUserName;
  final bool editingAge;
  final String language;

  @override
  List<Object> get props => [
        userName,
        age,
        editingAge,
        editingUserName,
        language,
      ];
}

final class ProfileInitializationFailed extends ProfileState {
  const ProfileInitializationFailed();
}

final class LogOutFailed extends ProfileState {
  const LogOutFailed();
}

final class LoggedOut extends ProfileState {
  const LoggedOut();
}

final class LanguageChanged extends ProfileState {}

final class LanguageChangeFailed extends ProfileState {}
