part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class InitialProfileEvent extends ProfileEvent {}

class LogOutEvent extends ProfileEvent {}

class UserNameEditEvent extends ProfileEvent {}

class AgeEditEvent extends ProfileEvent {}

class ChangeUserNameEvent extends ProfileEvent {
  const ChangeUserNameEvent({required this.userName});
  final String userName;
}

class ChangeAgeEvent extends ProfileEvent {
  const ChangeAgeEvent({required this.age});
  final String age;
}

class ChangeLanguageEvent extends ProfileEvent {
  const ChangeLanguageEvent({required this.language});
  final String language;
}
