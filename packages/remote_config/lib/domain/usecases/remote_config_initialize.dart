part of remote_config;

class RemoteConfigInitializeUseCase {
  const RemoteConfigInitializeUseCase();

  Future<void> call() async {
    const List<RemoteConfigEnum> allEnums = TypeEnum.values;
    Map<String, dynamic> defaultParameters = _getDefaults(allEnums);

    final remoteConfig = FirebaseRemoteConfig.instance;
    late RemoteConfigSettings settings;

    settings = RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    );

    await remoteConfig.setConfigSettings(settings);
    await remoteConfig.setDefaults(defaultParameters);

    try {
      bool updated = await remoteConfig.fetchAndActivate();
      print("[RemoteConfig] Fetch and activate completed: $updated");
    } catch (_) {}
  }

  Map<String, dynamic> _getDefaults(List<RemoteConfigEnum> enums) {
    final Map<String, dynamic> defaults = {};
    for (final enumValue in enums) {
      defaults[_getEnumName(enumValue)] = enumValue.defaultValue;
    }
    return defaults;
  }

  String _getEnumName(RemoteConfigEnum enumValue) {
    return (enumValue as Enum).name;
  }
}
