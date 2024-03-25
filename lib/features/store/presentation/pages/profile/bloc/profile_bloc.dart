import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/features/store/domain/repositories/authentication_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationRepository _authenticationRepository =
      locator.get<AuthenticationRepository>();
  ProfileBloc() : super(const ProfileInitial()) {
    on<InitialProfileEvent>(
      (event, emit) async {
        await _authenticationRepository.getUser().then(
              (value) => value.fold(
                (l) {
                  emit(const ProfileInitializationFailed());
                },
                (r) async {
                  emit(
                    ProfileInitialized(
                      language:
                          await _authenticationRepository.getLanguage().then(
                                (value) => value.fold((l) => '', (r) => r),
                              ),
                      age: r.age,
                      userName: r.userName,
                      editingUserName: false,
                      editingAge: false,
                    ),
                  );
                },
              ),
            );
      },
    );

    on<LogOutEvent>(
      (event, emit) async {
        await _authenticationRepository.logOut().then(
              (value) => value.fold(
                (l) => emit(
                  const LogOutFailed(),
                ),
                (r) => emit(
                  const LoggedOut(),
                ),
              ),
            );
      },
    );

    on<UserNameEditEvent>(
      (event, emit) async {
        await _authenticationRepository.getUser().then(
              (value) => value.fold(
                (l) {
                  emit(const ProfileInitializationFailed());
                },
                (r) async {
                  emit(
                    ProfileInitialized(
                      language:
                          await _authenticationRepository.getLanguage().then(
                                (value) => value.fold((l) => '', (r) => r),
                              ),
                      age: r.age,
                      userName: r.userName,
                      editingUserName: true,
                      editingAge: false,
                    ),
                  );
                },
              ),
            );
      },
    );

    on<ChangeUserNameEvent>(
      (event, emit) async {
        await _authenticationRepository.changeUserName(event.userName);
        await _authenticationRepository.getUser().then(
              (value) => value.fold(
                (l) {
                  emit(const ProfileInitializationFailed());
                },
                (r) async {
                  emit(
                    ProfileInitialized(
                      language:
                          await _authenticationRepository.getLanguage().then(
                                (value) => value.fold((l) => '', (r) => r),
                              ),
                      age: r.age,
                      userName: r.userName,
                      editingAge: false,
                      editingUserName: false,
                    ),
                  );
                },
              ),
            );
      },
    );

    on<AgeEditEvent>(
      (event, emit) async {
        await _authenticationRepository.getUser().then(
              (value) => value.fold(
                (l) {
                  emit(const ProfileInitializationFailed());
                },
                (r) async {
                  emit(
                    ProfileInitialized(
                      language:
                          await _authenticationRepository.getLanguage().then(
                                (value) => value.fold((l) => '', (r) => r),
                              ),
                      age: r.age,
                      userName: r.userName,
                      editingUserName: false,
                      editingAge: true,
                    ),
                  );
                },
              ),
            );
      },
    );

    on<ChangeAgeEvent>(
      (event, emit) async {
        await _authenticationRepository.changeAge(event.age);
        await _authenticationRepository.getUser().then(
              (value) => value.fold(
                (l) {
                  emit(const ProfileInitializationFailed());
                },
                (r) async {
                  emit(
                    ProfileInitialized(
                      language:
                          await _authenticationRepository.getLanguage().then(
                                (value) => value.fold((l) => '', (r) => r),
                              ),
                      age: r.age,
                      userName: r.userName,
                      editingAge: false,
                      editingUserName: false,
                    ),
                  );
                },
              ),
            );
      },
    );

    on<ChangeLanguageEvent>(
      (event, emit) async {
        await _authenticationRepository.changeLanguage(event.language).then(
              (value) => value.fold(
                (l) => emit(LanguageChangeFailed()),
                (r) => emit(LanguageChanged()),
              ),
            );
      },
    );
  }
}
