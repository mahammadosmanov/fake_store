import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/core/router/route_constants.dart';
import 'package:test_task/features/store/presentation/pages/home/bloc/home_bloc.dart';
import 'package:test_task/features/store/presentation/pages/home/bloc/switch_bloc.dart';
import 'package:test_task/features/store/presentation/pages/home/home.dart';
import 'package:test_task/features/store/presentation/pages/login/bloc/login_bloc.dart';
import 'package:test_task/features/store/presentation/pages/login/login.dart';
import 'package:test_task/features/store/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:test_task/features/store/presentation/pages/profile/profile.dart';
import 'package:test_task/features/store/presentation/pages/splash/bloc/splash_bloc.dart';
import 'package:test_task/features/store/presentation/pages/splash/splash.dart';
import 'package:test_task/features/store/presentation/pages/store/store.dart';

class AppRouter {
  AppRouter._();

  static AppRouter instance = AppRouter._();

  static GoRouter goRouter = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: [
      GoRoute(
        name: RouteConstants.login,
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create: (BuildContext context) => LoginBloc(),
              child: LoginView(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.home,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(
                  create: (BuildContext context) =>
                      HomeBloc()..add(const InitialEvent()),
                ),
                BlocProvider<SwitchBloc>(
                  create: (BuildContext context) => SwitchBloc(),
                ),
              ],
              child: locator.get<HomeView>(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.splash,
        path: '/splash',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create: (BuildContext context) => SplashBloc()
                ..add(
                  CheckLoginEvent(),
                ),
              child: const SplashView(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.profile,
        path: '/profile',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create: (BuildContext context) => ProfileBloc(),
              child: ProfileView(),
            ),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.store,
        path: '/store',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(
                  create: (BuildContext context) => HomeBloc()
                    ..add(
                      const InitialEvent(),
                    ),
                ),
                BlocProvider<SwitchBloc>(
                  create: (BuildContext context) => SwitchBloc(),
                ),
                BlocProvider(
                  create: (BuildContext context) => ProfileBloc()
                    ..add(
                      InitialProfileEvent(),
                    ),
                  child: ProfileView(),
                ),
              ],
              child: StoreView(),
            ),
          );
        },
      ),
    ],
  );
}
