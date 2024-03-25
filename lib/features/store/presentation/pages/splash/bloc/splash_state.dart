part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class NavigationState extends SplashState {
  const NavigationState({
    required this.navigateToHome,
  });
  final bool navigateToHome;
  @override
  List<Object> get props => [navigateToHome];
}

final class EnglishState extends SplashState {
  const EnglishState({
    required this.language,
  });
  final String language;
  @override
  List<Object> get props => [language];
}

final class TurkishState extends SplashState {
  const TurkishState({
    required this.language,
  });
  final String language;

  @override
  List<Object> get props => [language];
}

final class AzerbaijanState extends SplashState {
  const AzerbaijanState({
    required this.language,
  });
  final String language;
  @override
  List<Object> get props => [language];
}

final class FailureState extends SplashState {}
