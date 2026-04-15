import 'package:my_portfolio/core/remote_config/domain/entities/remote_config_enum.dart';

interface class RemoteConfigService {
  T getValue<T>(RemoteConfigEnum enumValue) {
    throw UnimplementedError();
  }
}
