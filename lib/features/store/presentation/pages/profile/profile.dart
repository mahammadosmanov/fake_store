import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/router/route_constants.dart';
import 'package:test_task/features/store/presentation/pages/profile/bloc/profile_bloc.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              context.go(RouteConstants.splash);
            }
            if (state is LanguageChanged) {
              context.go(RouteConstants.splash);
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xffEDEDED),
            appBar: AppBar(
              shape: const BorderDirectional(
                bottom: BorderSide(
                  width: 4,
                  color: Colors.black,
                ),
              ),
              title: Text(
                tr("profile"),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildUserInfo(
                    onTapEditUserName: () {
                      context.read<ProfileBloc>().add(
                            UserNameEditEvent(),
                          );
                    },
                    onTapDoneUserName: (userName) {
                      context.read<ProfileBloc>().add(
                            ChangeUserNameEvent(userName: userName),
                          );
                    },
                    onTapEditAge: () {
                      context.read<ProfileBloc>().add(
                            AgeEditEvent(),
                          );
                    },
                    onTapDoneAge: (age) {
                      context.read<ProfileBloc>().add(
                            ChangeAgeEvent(age: age),
                          );
                    },
                    state: state,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildLanguageOptions(
                      language: state is ProfileInitialized
                          ? state.language
                          : "English",
                      onTapEnglish: (language) async {
                        context
                            .read<ProfileBloc>()
                            .add(ChangeLanguageEvent(language: language));
                      },
                      onTapAzerbaijan: (language) {
                        context
                            .read<ProfileBloc>()
                            .add(ChangeLanguageEvent(language: language));
                      },
                      onTapTurkish: (language) {
                        context
                            .read<ProfileBloc>()
                            .add(ChangeLanguageEvent(language: language));
                      },
                    ),
                  ),
                  if (state is ProfileInitializationFailed)
                    const Text(
                      'Unexpected Problem occured',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  const Spacer(),
                  Center(
                    child: _buildSignOutButton(
                      () {
                        context.read<ProfileBloc>().add(LogOutEvent());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfo({
    required Function() onTapEditUserName,
    required Function(String userName) onTapDoneUserName,
    required Function() onTapEditAge,
    required Function(String age) onTapDoneAge,
    required ProfileState state,
  }) {
    return Column(
      children: [
        _buildUserName(
          onTapDoneUserName: onTapDoneUserName,
          onTapEditUserName: onTapEditUserName,
          state: state,
        ),
        _buildAge(
          onTapDoneAge: onTapDoneAge,
          onTapEditAge: onTapEditAge,
          state: state,
        ),
        if (state is ProfileInitial)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget _buildUserName({
    required Function() onTapEditUserName,
    required Function(String userName) onTapDoneUserName,
    required ProfileState state,
  }) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              "${tr("userName")}: ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (state is ProfileInitial) const CircularProgressIndicator(),
            if (state is ProfileInitialized && !state.editingUserName)
              Row(
                children: [
                  Text(
                    state.userName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: onTapEditUserName,
                    child: const Card(
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            if (state is ProfileInitialized && state.editingUserName)
              Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: TextField(
                      controller: userNameController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: tr("nameEntrance"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onTapDoneUserName(userNameController.text);
                    },
                    child: const Icon(Icons.done),
                  ),
                ],
              ),
          ],
        )
      ],
    );
  }

  Widget _buildAge({
    required Function() onTapEditAge,
    required Function(String age) onTapDoneAge,
    required ProfileState state,
  }) {
    return Row(
      children: [
        Text(
          "${tr("age")}: ",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (state is ProfileInitial) const CircularProgressIndicator(),
        if (state is ProfileInitialized && !state.editingAge)
          Row(
            children: [
              Text(
                state.age,
                style: const TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: onTapEditAge,
                child: const Card(
                  child: Icon(Icons.edit),
                ),
              ),
            ],
          ),
        if (state is ProfileInitialized && state.editingAge)
          Row(
            children: [
              SizedBox(
                width: 160,
                child: TextField(
                  controller: ageController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: tr("ageEntrance"),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onTapDoneAge(ageController.text);
                },
                child: const Icon(Icons.done),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildLanguageOptions({
    required Function(String language) onTapEnglish,
    required Function(String language) onTapAzerbaijan,
    required Function(String language) onTapTurkish,
    required String language,
  }) {
    return DropdownButton<String>(
      value: language,
      icon: const Icon(Icons.language),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {},
      items: [
        DropdownMenuItem(
          value: "English",
          onTap: () {
            onTapEnglish("English");
          },
          child: Text(
            tr("english"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        DropdownMenuItem(
          value: "Azerbaijan",
          onTap: () {
            onTapAzerbaijan("Azerbaijan");
          },
          child: Text(
            tr("azerbaijan"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        DropdownMenuItem(
          value: "Turkish",
          onTap: () {
            onTapTurkish("Turkish");
          },
          child: Text(
            tr("turkish"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutButton(Function() onTap) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        tr(
          "signOut",
        ),
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
