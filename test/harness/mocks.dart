import 'package:mocktail/mocktail.dart';
import 'package:my_portfolio/core/remote_config/remote_config.dart';

class MockRemoteConfigRepository extends Mock
    implements RemoteConfigRepository {}

class MockRemoteConfigService extends Mock implements RemoteConfigService {}

class FakeRemoteConfigEnum extends Fake implements RemoteConfigEnum {}

void registerFallbacks() {
  registerFallbackValue(FakeRemoteConfigEnum());
}
