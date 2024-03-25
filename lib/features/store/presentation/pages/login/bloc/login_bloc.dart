import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task/features/store/data/repositories/authentication_repositoryimpl.dart';
import 'package:test_task/features/store/domain/repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository auth = AuthenticationRepositoryImpl();
  LoginBloc() : super(LoginInitial()) {
    on<TapLoginEvent>(
      (event, emit) async {
        await auth.login(event.username, event.password).then(
              (value) => value.fold(
                (l) => emit(LoginFailed()),
                (r) => emit(LoggedIn()),
              ),
            );
      },
    );
  }
}
