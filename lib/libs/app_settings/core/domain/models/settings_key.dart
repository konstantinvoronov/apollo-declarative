import 'settings_key_type.dart';

class SettingsKey <T> {
  final SettingsKeyType keyType;
  final String keyName;
  final T? defaultValue;
  const SettingsKey({required this.keyType, required this.keyName,this.defaultValue});
}
