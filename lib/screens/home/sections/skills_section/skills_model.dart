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
    mobileDev,
    backend,
    languages,
    tools,
  ];

  static final mobileDev = SkillsSectionCategory(
    title: t.skills.categories.mobileDev.title,
    icon: Icons.phone_android_rounded,
    skills: const [
      'Flutter',
      'Dart',
      'Riverpod',
      'Bloc',
      'MobX',
      'MVVM',
      'Clean Architecture',
      'TDD',
      'Native Plugins',
    ],
  );

  static final backend = SkillsSectionCategory(
    title: t.skills.categories.backend.title,
    icon: Icons.cloud_rounded,
    skills: const [
      'Firebase (Full Suite)',
      'Node.js',
      'GraphQL',
      'REST APIs',
      'SQL',
      'NoSQL',
    ],
  );

  static final languages = SkillsSectionCategory(
    title: t.skills.categories.languages.title,
    icon: Icons.code_rounded,
    skills: const ['Dart', 'Java', 'Kotlin', 'JavaScript', 'TypeScript'],
  );

  static final tools = SkillsSectionCategory(
    title: t.skills.categories.tools.title,
    icon: Icons.build_rounded,
    skills: const [
      'Git',
      'CI/CD',
      'Figma',
      'ASO',
      'Monetization',
      'Codemagic',
      'GitHub Actions',
    ],
  );
}
