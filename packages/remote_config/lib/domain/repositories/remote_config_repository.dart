part of remote_config;

abstract class RemoteConfigRepository {
  T getValue<T>(RemoteConfigEnum enumValue);
}
