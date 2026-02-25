part of remote_config;

class FirebaseRemoteConfigServiceImpl implements RemoteConfigService {
  FirebaseRemoteConfig get _instance => FirebaseRemoteConfig.instance;

  @override
  T getValue<T>(RemoteConfigEnum enumValue) {
    var value = _instance.getValue((enumValue as Enum).name);
    if (value.source == ValueSource.valueStatic) {
      return enumValue.defaultValue as T;
    }

    try {
      if (T == int) {
        return value.asInt() as T;
      } else if (T == double) {
        return value.asDouble() as T;
      } else if (T == String) {
        return value.asString() as T;
      } else if (T == bool) {
        return value.asBool() as T;
      } else {
        return enumValue.defaultValue as T;
      }
    } catch (e) {
      return enumValue.defaultValue as T;
    }
  }
}
