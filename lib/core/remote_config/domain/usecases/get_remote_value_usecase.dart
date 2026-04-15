import 'package:my_portfolio/core/remote_config/domain/entities/remote_config_enum.dart';
import 'package:my_portfolio/core/remote_config/domain/repositories/remote_config_repository.dart';

class GetRemoteValueUseCase {
  GetRemoteValueUseCase(this.repository);

  final RemoteConfigRepository repository;

  T call<T>(RemoteConfigEnum enumValue, {required T defaultValue}) {
    try {
      return repository.getValue<T>(enumValue);
    } on Object {
      return defaultValue;
    }
  }

  int callInt(RemoteConfigEnum enumValue) {
    return call<int>(enumValue, defaultValue: enumValue.defaultValue as int);
  }

  double callDouble(RemoteConfigEnum enumValue) {
    return call<double>(
      enumValue,
      defaultValue: enumValue.defaultValue as double,
    );
  }

  String callString(RemoteConfigEnum enumValue) {
    return call<String>(
      enumValue,
      defaultValue: enumValue.defaultValue as String,
    );
  }

  bool callBool(RemoteConfigEnum enumValue) {
    return call<bool>(enumValue, defaultValue: enumValue.defaultValue as bool);
  }

  List<int> callIntList(RemoteConfigEnum enumValue) {
    var value = call<String>(enumValue, defaultValue: '');
    if (value.isEmpty) {
      return enumValue.defaultValue as List<int>;
    }

    value = value.replaceAll('[', '').replaceAll(']', '').trim();

    try {
      final intList = value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .map((e) {
            final number = int.tryParse(e);
            if (number == null) {
              throw const FormatException('Invalid number format');
            }
            return number;
          })
          .toList();
      return intList;
    } on FormatException {
      return enumValue.defaultValue as List<int>;
    }
  }
}
