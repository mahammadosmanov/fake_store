import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/router/route_constants.dart';
import 'package:test_task/features/store/presentation/pages/splash/bloc/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is EnglishState) {
          context.setLocale(
            const Locale('en'),
          );
        }
        if (state is AzerbaijanState) {
          context.setLocale(
            const Locale('az'),
          );
        }
        if (state is TurkishState) {
          context.setLocale(
            const Locale('tr'),
          );
        }
        if (state is NavigationState) {
          if (state.navigateToHome) {
            context.go(RouteConstants.store);
          } else {
            context.go(RouteConstants.login);
          }
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) => Scaffold(
          body: Center(
            child: Text(
              tr("fakeStore"),
              style: const TextStyle(
                fontSize: 50,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
