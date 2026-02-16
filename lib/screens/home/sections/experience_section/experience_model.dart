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
    title: t.experience.items.bluStudios.title,
    company: AppConstants.bluCompany,
    period: t.experience.items.bluStudios.period,
    location: t.experience.items.bluStudios.location,
    points: t.experience.items.bluStudios.points,
  );

  static final vxCase = ExperienceSectionData(
    title: t.experience.items.vxCase.title,
    company: AppConstants.vxCaseCompany,
    period: t.experience.items.vxCase.period,
    location: t.experience.items.vxCase.location,
    points: t.experience.items.vxCase.points,
  );

  static final tecall = ExperienceSectionData(
    title: t.experience.items.tecall.title,
    company: AppConstants.tecallCompany,
    period: t.experience.items.tecall.period,
    location: t.experience.items.tecall.location,
    points: t.experience.items.tecall.points,
  );
}
