import 'package:dartz/dartz.dart';
import 'package:test_task/core/error/failure/failure.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/features/store/data/datasources/store_datasource.dart';
import 'package:test_task/features/store/data/datasources/local_datasource.dart';
import 'package:test_task/features/store/domain/entities/user_entity.dart';
import 'package:test_task/features/store/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final StoreDataSource _fakeStoreDataSource = locator.get<StoreDataSource>();
  final LocalDataSource _localDataSource = locator.get<LocalDataSource>();

  @override
  Future<Either<Failure, UserEntity>> login(
      String userName, String password) async {
    try {
      String token = await _fakeStoreDataSource.login(userName, password);
      _localDataSource.saveAuthInfo(token, userName);
      return right(
        UserEntity(userName: userName, age: '0'),
      );
    } catch (e) {
      return left(
        AuthenticationFailure(),
      );
    }
  }

  @override
  Future<bool> checkLoginStatus() async {
    try {
      String token = await _localDataSource.getToken();
      if (token != '') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      return right(await _localDataSource.deleteToken());
    } catch (e) {
      return left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getUserName() async {
    try {
      return right(await _localDataSource.getUserName());
    } catch (e) {
      return left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeAge(String age) async {
    try {
      return right(await _localDataSource.changeAge(age));
    } catch (e) {
      return left(ProfileFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeUserName(String userName) async {
    try {
      return right(await _localDataSource.changeUserName(userName));
    } catch (e) {
      return left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getAge() async {
    try {
      return right(await _localDataSource.getAge());
    } catch (e) {
      return left(AuthenticationFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      return right(
        UserEntity(
          userName: await _localDataSource.getUserName(),
          age: await _localDataSource.getAge(),
        ),
      );
    } catch (e) {
      return left(ProfileFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeLanguage(String language) async {
    try {
      return right(await _localDataSource.saveLanguage(language));
    } catch (e) {
      return left(LanguageFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      return right(await _localDataSource.getLanguage());
    } catch (e) {
      return left(LanguageFailure());
    }
  }
}
