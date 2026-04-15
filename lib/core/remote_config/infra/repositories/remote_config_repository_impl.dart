import 'package:my_portfolio/core/remote_config/domain/entities/remote_config_enum.dart';
import 'package:my_portfolio/core/remote_config/domain/repositories/remote_config_repository.dart';
import 'package:my_portfolio/core/remote_config/infra/services/remote_config_service.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  RemoteConfigRepositoryImpl(this.remoteConfigService);

  final RemoteConfigService remoteConfigService;

  @override
  T getValue<T>(RemoteConfigEnum enumValue) {
    return remoteConfigService.getValue<T>(enumValue);
  }
}
