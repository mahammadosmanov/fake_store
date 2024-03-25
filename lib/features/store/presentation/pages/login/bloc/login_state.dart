part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {}

final class LoginInitial extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LoggedIn extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LoginFailed extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
