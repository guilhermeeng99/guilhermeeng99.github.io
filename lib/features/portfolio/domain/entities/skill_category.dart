import 'package:flutter/material.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class SkillsSectionCategory {
  const SkillsSectionCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });

  final String title;
  final IconData icon;
  final List<String> skills;

  static final List<SkillsSectionCategory> categories = [
    coreEngineering,
    architectureBackend,
    devopsProduction,
  ];

  static final coreEngineering = SkillsSectionCategory(
    title: t.skills.categories.core_engineering.title,
    icon: Icons.phone_android_rounded,
    skills: const [
      'Flutter',
      'Dart',
      'Design Patterns',
      'REST APIs',
      'Clean Architecture',
      'State Management',
      'WebSockets',
      'BLoC',
      'Unit Tests',
      'SOLID',
      'DDD',
      'TDD',
      'Cubit',
      'Riverpod',
      'KISS',
      'DRY',
      'OOP',
      'Provider',
      'GetX',
      'MobX',
      'Widget Tests',
    ],
  );

  static final architectureBackend = SkillsSectionCategory(
    title: t.skills.categories.architecture_backend.title,
    icon: Icons.cloud_rounded,
    skills: const [
      'Feature-First Architecture',
      'Hive Database',
      'DI',
      'Drift Database',
      'Realtime Database',
      'FCM',
      'GetIt',
      'Modular',
      'Firebase Auth',
      'Firebase Cloud Storage',
      'Provider',
      'Firestore',
      'Supabase',
      'Isar Database',
      'Remote Config',
      'Analytics',
      'Platform Channels',
      'Android',
      'Crashlytics',
      'iOS',
    ],
  );

  static final devopsProduction = SkillsSectionCategory(
    title: t.skills.categories.devops_production.title,
    icon: Icons.build_rounded,
    skills: const [
      'CI/CD Pipelines',
      'CodeMagic',
      'Performance Optimization',
      'Braze',
      'Fastlane',
      'Firebase App Distribution',
      'Crash & ANR Reduction',
      'Git',
      'Memory Leak Debugging',
      'GitHub',
      'Build Flavors',
      'NewRelic',
      'Optimizely',
      'Rive',
    ],
  );
}
