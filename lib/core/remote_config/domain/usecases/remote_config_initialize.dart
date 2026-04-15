import 'dart:developer' as developer;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_portfolio/core/remote_config/domain/entities/remote_config_enum.dart';
import 'package:my_portfolio/core/remote_config/domain/entities/type_enum.dart';

class RemoteConfigInitializeUseCase {
  const RemoteConfigInitializeUseCase();

  Future<void> call() async {
    final defaultParameters = _getDefaults(TypeEnum.values);
    final remoteConfig = FirebaseRemoteConfig.instance;
    final settings = RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    );

    await remoteConfig.setConfigSettings(settings);
    await remoteConfig.setDefaults(defaultParameters);

    try {
      await remoteConfig.fetchAndActivate();
    } on Object catch (error, stackTrace) {
      developer.log(
        'Failed to fetch and activate Remote Config.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Map<String, Object> _getDefaults(List<RemoteConfigEnum> enums) => {
    for (final enumValue in enums) enumValue.key: enumValue.defaultValue,
  };
}
