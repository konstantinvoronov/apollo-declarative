import 'package:app_failure/app_failure.dart';
/*
class NameValidator extends AppResourceValidator<String> {
  @override
  Future<Either<AppFailure, String>> validate(String value) async {
    final v = value.trim() ?? '';
    if (v.isEmpty) {
      final failure = AppFailure.ValidationFailure('Field could not be empty');
      return Left(failure);
    }
    return Right(value);
  }
 */

abstract class AppResourceValidator<T> {

  AppResourceValidator();

  Future<AppResult<T>> validate(T value);
}
