part of remote_config;

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final RemoteConfigService remoteConfigService;

  RemoteConfigRepositoryImpl(this.remoteConfigService);

  @override
  T getValue<T>(RemoteConfigEnum enumValue) {
    return remoteConfigService.getValue<T>(enumValue);
  }
}
