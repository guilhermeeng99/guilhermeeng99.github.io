import 'package:my_portfolio/app/app_constants.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class ExperienceSectionData {
  const ExperienceSectionData({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.points,
  });

  final String title;
  final String company;
  final String period;
  final String location;
  final List<String> points;

  static final List<ExperienceSectionData> experiences = [
    bluStudios,
    vxCase,
    tecall,
  ];

  static final bluStudios = ExperienceSectionData(
    title: t.experience.items.blu_studios.title,
    company: AppConstants.bluCompany,
    period: t.experience.items.blu_studios.period,
    location: t.experience.items.blu_studios.location,
    points: t.experience.items.blu_studios.points,
  );

  static final vxCase = ExperienceSectionData(
    title: t.experience.items.vx_case.title,
    company: AppConstants.vxCaseCompany,
    period: t.experience.items.vx_case.period,
    location: t.experience.items.vx_case.location,
    points: t.experience.items.vx_case.points,
  );

  static final tecall = ExperienceSectionData(
    title: t.experience.items.tecall.title,
    company: AppConstants.tecallCompany,
    period: t.experience.items.tecall.period,
    location: t.experience.items.tecall.location,
    points: t.experience.items.tecall.points,
  );
}
