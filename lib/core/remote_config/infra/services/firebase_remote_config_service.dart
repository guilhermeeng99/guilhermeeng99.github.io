import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_portfolio/core/remote_config/domain/entities/remote_config_enum.dart';
import 'package:my_portfolio/core/remote_config/infra/services/remote_config_service.dart';

class FirebaseRemoteConfigServiceImpl implements RemoteConfigService {
  FirebaseRemoteConfig get _instance => FirebaseRemoteConfig.instance;

  @override
  T getValue<T>(RemoteConfigEnum enumValue) {
    final remoteValue = _instance.getValue(enumValue.key);
    if (remoteValue.source == ValueSource.valueStatic) {
      return enumValue.defaultValue as T;
    }

    try {
      if (T == int) {
        return remoteValue.asInt() as T;
      } else if (T == double) {
        return remoteValue.asDouble() as T;
      } else if (T == String) {
        return remoteValue.asString() as T;
      } else if (T == bool) {
        return remoteValue.asBool() as T;
      } else {
        return enumValue.defaultValue as T;
      }
    } on Object {
      return enumValue.defaultValue as T;
    }
  }
}
