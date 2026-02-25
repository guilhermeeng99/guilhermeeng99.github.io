part of remote_config;

class GetRemoteValueUseCase {
  final RemoteConfigRepository repository;

  GetRemoteValueUseCase(this.repository);

  T call<T>(RemoteConfigEnum enumValue, {required T defaultValue}) {
    try {
      return repository.getValue<T>(enumValue);
    } catch (e) {
      return defaultValue;
    }
  }

  int callInt(RemoteConfigEnum enumValue) {
    return call<int>(enumValue, defaultValue: enumValue.defaultValue as int);
  }

  double callDouble(RemoteConfigEnum enumValue) {
    return call<double>(enumValue,
        defaultValue: enumValue.defaultValue as double);
  }

  String callString(RemoteConfigEnum enumValue) {
    return call<String>(enumValue,
        defaultValue: enumValue.defaultValue as String);
  }

  bool callBool(RemoteConfigEnum enumValue) {
    return call<bool>(enumValue, defaultValue: enumValue.defaultValue as bool);
  }

  List<int> callIntList(RemoteConfigEnum enumValue) {
    String value = call<String>(enumValue, defaultValue: '');
    if (value.isEmpty) {
      return enumValue.defaultValue as List<int>;
    }

    value = value.replaceAll('[', '').replaceAll(']', '').trim();

    try {
      List<int> intList = value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .map((e) {
        int? number = int.tryParse(e);
        if (number == null) {
          throw FormatException('Invalid number format: $e');
        }
        return number;
      }).toList();
      return intList;
    } catch (e) {
      return enumValue.defaultValue as List<int>;
    }
  }
}
