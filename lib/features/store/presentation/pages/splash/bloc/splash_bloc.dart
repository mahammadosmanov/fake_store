import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/features/store/domain/repositories/authentication_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenticationRepository _authenticationRepository =
      locator.get<AuthenticationRepository>();
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});

    on<CheckLoginEvent>(
      (event, emit) async {
        await _authenticationRepository
            .getLanguage()
            .then((value) => value.fold((l) => emit(FailureState()), (r) {
                  if (r == "English") {
                    emit(
                      EnglishState(language: r),
                    );
                  } else if (r == "Azerbaijan") {
                    emit(
                      AzerbaijanState(language: r),
                    );
                  } else if (r == "Turkish") {
                    emit(
                      TurkishState(language: r),
                    );
                  }
                }));
        await _authenticationRepository.checkLoginStatus().then(
              (value) => emit(
                NavigationState(navigateToHome: value),
              ),
            );
      },
    );
  }
}
