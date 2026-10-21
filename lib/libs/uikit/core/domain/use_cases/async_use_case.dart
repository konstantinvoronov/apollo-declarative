import 'package:app_failure/app_failure.dart';

/// Интерфейс для асинхронных юзкейсов
/// Наследоваться от этого класса, если функция юзкейса вызывает другие сервисы асинхронно,
/// то есть результат вычисления будет известен позже
abstract class AsyncUseCase<ParamsT, ResultT> {
  Future<AppResult<ResultT>> call(ParamsT params);
}
