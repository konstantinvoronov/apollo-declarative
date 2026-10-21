import 'package:app_failure/app_failure.dart';

/// Интерфейс для синхронных юзкейсов
/// Наследоваться от этого класса, если функция юзкейса синхранная, то есть
/// резельтат вычисления доступен сразу
abstract class SyncUseCase<ParamsT, ResultT> {
  AppResult<ResultT> call(ParamsT params);
}
