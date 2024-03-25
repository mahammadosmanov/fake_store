import 'package:test_task/core/error/failure/failure.dart';
import 'package:test_task/features/store/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> login(
    String userName,
    String password,
  );

  Future<bool> checkLoginStatus();

  Future<Either<Failure, void>> logOut();

  Future<Either<Failure, String>> getUserName();

  Future<Either<Failure, String>> getAge();

  Future<Either<Failure, void>> changeUserName(
    String userName,
  );

  Future<Either<Failure, void>> changeAge(
    String age,
  );

  Future<Either<Failure, UserEntity>> getUser();

  Future<Either<Failure, void>> changeLanguage(String language);

  Future<Either<Failure, String>> getLanguage();
}
