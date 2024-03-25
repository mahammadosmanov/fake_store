class UserEntity {
  UserEntity({
    required this.userName,
    required this.age,
  });
  final String userName;
  final String age;
}

enum Gender {
  man,
  woman,
  notDefined,
  dontWantToDefine,
}
