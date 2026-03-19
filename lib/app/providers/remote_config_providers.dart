import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:remote_config/remote_config.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final remoteConfigService = FirebaseRemoteConfigServiceImpl();
    final remoteConfigRepository = RemoteConfigRepositoryImpl(
      remoteConfigService,
    );
    final getRemoteValue = GetRemoteValueUseCase(remoteConfigRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RemoteConfigInitializeUseCase>(
          create: (_) => const RemoteConfigInitializeUseCase(),
        ),
        RepositoryProvider<RemoteConstants>(
          create: (_) => RemoteConstants(getRemoteValue),
        ),
      ],
      child: child,
    );
  }
}
