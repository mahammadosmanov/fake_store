part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class TapLoginEvent extends LoginEvent {
  TapLoginEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
