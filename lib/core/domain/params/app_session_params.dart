import '../models/settings_key.dart';
import '../models/settings_key_type.dart';

sealed class AppSessionParams<T> {
  final String keyName;
  final SettingsKeyType keyType;
  final bool onlyMemory;
  final bool sessionDependent;
  final T? defaultValue;

  const AppSessionParams({
    required this.keyName,
    required this.keyType,
    this.onlyMemory = false,
    this.sessionDependent = true,
    this.defaultValue,
  });

  SettingsKey<T> get settingsKey => SettingsKey<T>(
    keyName: keyName,
    keyType: keyType,
    defaultValue: defaultValue,
  );
}

// STRING
final class AppSessionStringParams extends AppSessionParams<String?> {
  const AppSessionStringParams({
    required super.keyName,
    super.onlyMemory,
    super.sessionDependent,
    super.defaultValue,
  }) : super(keyType: SettingsKeyType.string);

  const AppSessionStringParams.memory({
    required String keyName,
    bool sessionDependent = true,
    String? defaultValue,
  }) : this(
         keyName: keyName,
         onlyMemory: true,
         sessionDependent: sessionDependent,
         defaultValue: defaultValue,
       );
}

// INT
final class AppSessionIntParams extends AppSessionParams<int?> {
  const AppSessionIntParams({
    required super.keyName,
    super.onlyMemory,
    super.sessionDependent,
    super.defaultValue,
  }) : super(keyType: SettingsKeyType.int);

  const AppSessionIntParams.memory({
    required String keyName,
    bool sessionDependent = true,
    int? defaultValue,
  }) : this(
         keyName: keyName,
         onlyMemory: true,
         sessionDependent: sessionDependent,
         defaultValue: defaultValue,
       );
}

// BOOL
final class AppSessionBoolParams extends AppSessionParams<bool?> {
  const AppSessionBoolParams({
    required super.keyName,
    super.onlyMemory,
    super.sessionDependent,
    super.defaultValue,
  }) : super(keyType: SettingsKeyType.bool);

  const AppSessionBoolParams.memory({
    required String keyName,
    bool sessionDependent = true,
    bool? defaultValue,
  }) : this(
         keyName: keyName,
         onlyMemory: true,
         sessionDependent: sessionDependent,
         defaultValue: defaultValue,
       );
}

// JSON (generic)
final class AppSessionJsonParams<J> extends AppSessionParams<J> {
  const AppSessionJsonParams({
    required super.keyName,
    super.onlyMemory,
    super.sessionDependent,
    super.defaultValue,
  }) : super(keyType: SettingsKeyType.json);

  const AppSessionJsonParams.memory({
    required String keyName,
    bool sessionDependent = true,
    J? defaultValue,
  }) : this(
         keyName: keyName,
         onlyMemory: true,
         sessionDependent: sessionDependent,
         defaultValue: defaultValue,
       );
}
