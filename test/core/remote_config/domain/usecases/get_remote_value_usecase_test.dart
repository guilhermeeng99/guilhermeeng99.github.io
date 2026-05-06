import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_portfolio/core/remote_config/remote_config.dart';

import '../../../../harness/factories/remote_config_enum_factory.dart';
import '../../../../harness/helpers.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockRemoteConfigRepository repository;
  late GetRemoteValueUseCase useCase;

  setUp(() {
    repository = MockRemoteConfigRepository();
    useCase = GetRemoteValueUseCase(repository);
  });

  group('callString', () {
    test('returns the repository value when present', () {
      final key = RemoteConfigEnumFactory.string();
      when(() => repository.getValue<String>(key)).thenReturn('remote');

      expect(useCase.callString(key), 'remote');
    });

    test('falls back to the default when the repository throws', () {
      final key = RemoteConfigEnumFactory.string();
      when(() => repository.getValue<String>(key)).thenThrow(Exception('boom'));

      expect(useCase.callString(key), 'fallback');
    });
  });

  group('callInt', () {
    test('returns the repository value when present', () {
      final key = RemoteConfigEnumFactory.integer(defaultValue: 1);
      when(() => repository.getValue<int>(key)).thenReturn(42);

      expect(useCase.callInt(key), 42);
    });

    test('falls back to the default on error', () {
      final key = RemoteConfigEnumFactory.integer(defaultValue: 7);
      when(() => repository.getValue<int>(key)).thenThrow(Exception('boom'));

      expect(useCase.callInt(key), 7);
    });
  });

  group('callBool', () {
    test('returns the repository value when present', () {
      final key = RemoteConfigEnumFactory.boolean();
      when(() => repository.getValue<bool>(key)).thenReturn(true);

      expect(useCase.callBool(key), isTrue);
    });
  });

  group('callIntList', () {
    test('parses comma-separated integers', () {
      final key = RemoteConfigEnumFactory.integerList(defaultValue: const [0]);
      when(() => repository.getValue<String>(key)).thenReturn('[1, 2, 3]');

      expect(useCase.callIntList(key), [1, 2, 3]);
    });

    test('returns the default when the payload is empty', () {
      final key = RemoteConfigEnumFactory.integerList(defaultValue: const [9]);
      when(() => repository.getValue<String>(key)).thenReturn('');

      expect(useCase.callIntList(key), [9]);
    });

    test('returns the default when the payload is malformed', () {
      final key = RemoteConfigEnumFactory.integerList(defaultValue: const [5]);
      when(() => repository.getValue<String>(key)).thenReturn('1,abc,3');

      expect(useCase.callIntList(key), [5]);
    });
  });
}
