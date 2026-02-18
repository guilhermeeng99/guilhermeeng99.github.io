import 'package:my_portfolio/app/app_constants.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class ResumeSectionData {
  const ResumeSectionData({
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

  static final List<ResumeSectionData> resumes = [
    bluStudios,
    vxCase,
    tecall,
  ];

  static final bluStudios = ResumeSectionData(
    title: t.resume.experience.blu_studios.title,
    company: AppConstants.bluCompany,
    period: t.resume.experience.blu_studios.period,
    location: t.resume.experience.blu_studios.location,
    points: t.resume.experience.blu_studios.points,
  );

  static final vxCase = ResumeSectionData(
    title: t.resume.experience.vx_case.title,
    company: AppConstants.vxCaseCompany,
    period: t.resume.experience.vx_case.period,
    location: t.resume.experience.vx_case.location,
    points: t.resume.experience.vx_case.points,
  );

  static final tecall = ResumeSectionData(
    title: t.resume.experience.tecall.title,
    company: AppConstants.tecallCompany,
    period: t.resume.experience.tecall.period,
    location: t.resume.experience.tecall.location,
    points: t.resume.experience.tecall.points,
  );
}

class EducationData {
  const EducationData({
    required this.degree,
    required this.institution,
    required this.period,
    required this.location,
    required this.points,
  });

  final String degree;
  final String institution;
  final String period;
  final String location;
  final List<String> points;

  static final List<EducationData> educations = [
    ucsal,
    senaiCimatec,
    all,
  ];

  static final ucsal = EducationData(
    degree: t.resume.education.ucsal.degree,
    institution: AppConstants.ucsalInstitution,
    period: t.resume.education.ucsal.period,
    location: t.resume.education.ucsal.location,
    points: t.resume.education.ucsal.points,
  );

  static final senaiCimatec = EducationData(
    degree: t.resume.education.senai_cimatec.degree,
    institution: AppConstants.senaiInstitution,
    period: t.resume.education.senai_cimatec.period,
    location: t.resume.education.senai_cimatec.location,
    points: t.resume.education.senai_cimatec.points,
  );

  static final all = EducationData(
    degree: t.resume.education.all.degree,
    institution: AppConstants.allInstitution,
    period: t.resume.education.all.period,
    location: t.resume.education.all.location,
    points: t.resume.education.all.points,
  );
}
