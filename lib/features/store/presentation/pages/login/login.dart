import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/router/route_constants.dart';
import 'package:test_task/features/store/presentation/pages/login/bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoggedIn) {
          context.go(RouteConstants.store);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tr("welcome"),
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 12,
                ),
                _buildUserNameTextField(),
                const SizedBox(
                  height: 12,
                ),
                _buildPasswordTextField(),
                const SizedBox(
                  height: 12,
                ),
                _buildLoginButton(context),
                if (state is LoginFailed)
                  Text(
                    tr("failedToLogin"),
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
  ) {
    return FloatingActionButton(
      onPressed: () {
        context.read<LoginBloc>().add(
              TapLoginEvent(
                username: usernameController.text,
                password: passwordController.text,
              ),
            );
      },
      child: Text(
        tr("login"),
      ),
    );
  }

  Widget _buildUserNameTextField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: usernameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: tr("userName"),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.amber),
          ),
          hintText: tr("password"),
        ),
      ),
    );
  }
}
