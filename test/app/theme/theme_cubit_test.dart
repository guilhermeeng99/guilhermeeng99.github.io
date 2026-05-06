import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/theme/theme_cubit.dart';

void main() {
  group('ThemeCubit', () {
    test('starts in dark mode', () {
      final cubit = ThemeCubit();
      expect(cubit.state, ThemeMode.dark);
      expect(cubit.isDark, isTrue);
    });

    blocTest<ThemeCubit, ThemeMode>(
      'toggles dark → light → dark',
      build: ThemeCubit.new,
      act: (cubit) => cubit
        ..toggleTheme()
        ..toggleTheme(),
      expect: () => const [ThemeMode.light, ThemeMode.dark],
    );
  });
}
