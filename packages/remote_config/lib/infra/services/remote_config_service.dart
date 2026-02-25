part of remote_config;

abstract class RemoteConfigService {
  T getValue<T>(RemoteConfigEnum enumValue);
}
