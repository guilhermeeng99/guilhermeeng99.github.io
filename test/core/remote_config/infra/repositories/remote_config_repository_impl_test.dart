import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_portfolio/core/remote_config/remote_config.dart';

import '../../../../harness/factories/remote_config_enum_factory.dart';
import '../../../../harness/helpers.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockRemoteConfigService service;
  late RemoteConfigRepositoryImpl repository;

  setUp(() {
    service = MockRemoteConfigService();
    repository = RemoteConfigRepositoryImpl(service);
  });

  test('delegates getValue<String> to the service', () {
    final key = RemoteConfigEnumFactory.string();
    when(() => service.getValue<String>(key)).thenReturn('remote');

    expect(repository.getValue<String>(key), 'remote');
    verify(() => service.getValue<String>(key)).called(1);
  });

  test('delegates getValue<int> to the service', () {
    final key = RemoteConfigEnumFactory.integer();
    when(() => service.getValue<int>(key)).thenReturn(99);

    expect(repository.getValue<int>(key), 99);
    verify(() => service.getValue<int>(key)).called(1);
  });

  test('propagates service errors so the use case can wrap them', () {
    final key = RemoteConfigEnumFactory.string();
    when(() => service.getValue<String>(key)).thenThrow(Exception('boom'));

    expect(
      () => repository.getValue<String>(key),
      throwsA(isA<Exception>()),
    );
  });
}
