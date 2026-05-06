import 'package:my_portfolio/core/remote_config/remote_config.dart';

/// In-test enum value, decoupled from `TypeEnum`, so factories can be
/// re-typed (string, int, bool) without inventing new production keys.
class TestRemoteEnum implements RemoteConfigEnum {
  const TestRemoteEnum({required this.key, required this.defaultValue});

  @override
  final String key;

  @override
  final Object defaultValue;
}

abstract final class RemoteConfigEnumFactory {
  static TestRemoteEnum string({
    String key = 'test_string',
    String defaultValue = 'fallback',
  }) =>
      TestRemoteEnum(key: key, defaultValue: defaultValue);

  static TestRemoteEnum integer({
    String key = 'test_int',
    int defaultValue = 0,
  }) =>
      TestRemoteEnum(key: key, defaultValue: defaultValue);

  static TestRemoteEnum boolean({
    String key = 'test_bool',
    bool defaultValue = false,
  }) =>
      TestRemoteEnum(key: key, defaultValue: defaultValue);

  static TestRemoteEnum integerList({
    String key = 'test_int_list',
    List<int> defaultValue = const [],
  }) =>
      TestRemoteEnum(key: key, defaultValue: defaultValue);
}
