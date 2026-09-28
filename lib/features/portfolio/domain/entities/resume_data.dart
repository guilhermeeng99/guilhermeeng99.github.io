import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class ResumeSectionData {
  const ResumeSectionData({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.points,
    this.employmentType,
  });

  final String title;
  final String company;
  final String? employmentType;
  final String period;
  final String location;
  final List<String> points;

  static final List<ResumeSectionData> resumes = [
    sixtySixDegrees,
    arcDev,
    bluStudios,
    vxCase,
    tecall,
  ];

  static final sixtySixDegrees = ResumeSectionData(
    title: t.resume.experience.sixty_six_degrees.title,
    company: AppConstants.sixtySixDegreesCompany,
    employmentType: t.resume.experience.sixty_six_degrees.employment_type,
    period: t.resume.experience.sixty_six_degrees.period,
    location: t.resume.experience.sixty_six_degrees.location,
    points: t.resume.experience.sixty_six_degrees.points,
  );

  static final arcDev = ResumeSectionData(
    title: t.resume.experience.arc_dev.title,
    company: AppConstants.arcDevCompany,
    employmentType: t.resume.experience.arc_dev.employment_type,
    period: t.resume.experience.arc_dev.period,
    location: t.resume.experience.arc_dev.location,
    points: t.resume.experience.arc_dev.points,
  );

  static final bluStudios = ResumeSectionData(
    title: t.resume.experience.blu_studios.title,
    company: AppConstants.bluCompany,
    employmentType: t.resume.experience.blu_studios.employment_type,
    period: t.resume.experience.blu_studios.period,
    location: t.resume.experience.blu_studios.location,
    points: t.resume.experience.blu_studios.points,
  );

  static final vxCase = ResumeSectionData(
    title: t.resume.experience.vx_case.title,
    company: AppConstants.vxCaseCompany,
    employmentType: t.resume.experience.vx_case.employment_type,
    period: t.resume.experience.vx_case.period,
    location: t.resume.experience.vx_case.location,
    points: t.resume.experience.vx_case.points,
  );

  static final tecall = ResumeSectionData(
    title: t.resume.experience.tecall.title,
    company: AppConstants.tecallCompany,
    employmentType: t.resume.experience.tecall.employment_type,
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
