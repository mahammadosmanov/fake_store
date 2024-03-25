import 'package:hive_flutter/adapters.dart';
import 'package:test_task/core/error/exception/exception.dart';
import 'package:test_task/features/store/domain/entities/user_entity.dart';

abstract class LocalDataSource {
  Future<void> setup();
  Future<void> openBoxes();
  Future<void> deleteBoxes();
  Future<void> delete();
  Future<String> getAge();
  Future<void> saveAuthInfo(
    String token,
    String userName,
  );
  Future<void> changeUserName(
    String userName,
  );

  Future<void> changeAge(
    String age,
  );
  Future<void> changeGender(
    Gender gender,
  );

  Future<String> getToken();
  Future<String> getUserName();
  Future<void> deleteToken();
  Future<void> saveLanguage(String language);
  Future<String> getLanguage();
}

class HiveDataSourceImpl extends LocalDataSource {
  late Box authBox;
  late Box profileBox;
  late Box languageBox;

  @override
  Future<void> setup() async {
    await Hive.initFlutter();
    await openBoxes();
  }

  @override
  Future<void> openBoxes() async {
    authBox = await Hive.openBox('auth');
    profileBox = await Hive.openBox('profile');
    languageBox = await Hive.openBox('language');
  }

  @override
  Future<void> deleteBoxes() async {
    authBox.close();
  }

  @override
  Future<void> delete() async {
    await Hive.deleteFromDisk();
  }

  @override
  Future<void> saveAuthInfo(
    String token,
    String userName,
  ) async {
    try {
      await authBox.put('token', token);
      await authBox.put('userName', userName);
      await profileBox.put('age', '0');
      await languageBox.put('language', 'English');
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<String> getToken() async {
    try {
      return await authBox.get('token');
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      return await authBox.delete('token');
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<String> getUserName() async {
    try {
      return await authBox.get('userName');
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<void> changeUserName(String userName) async {
    try {
      await authBox.put('userName', userName);
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<void> changeAge(String age) async {
    try {
      await profileBox.put('age', age);
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<String> getAge() async {
    try {
      return await profileBox.get('age');
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<void> changeGender(Gender gender) async {
    try {
      await profileBox.put('gender', gender);
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<void> saveLanguage(String language) async {
    try {
      await languageBox.put('language', language);
    } catch (e) {
      throw HiveException();
    }
  }

  @override
  Future<String> getLanguage() async {
    try {
      return await languageBox.get('language');
    } catch (e) {
      throw HiveException();
    }
  }
}
