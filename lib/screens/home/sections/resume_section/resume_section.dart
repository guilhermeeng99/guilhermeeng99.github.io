import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:my_portfolio/screens/home/sections/resume_section/resume_model.dart';
import 'package:my_portfolio/screens/home/sections/resume_section/widgets/resume_section_download_button.dart';
import 'package:my_portfolio/screens/home/sections/resume_section/widgets/resume_section_education.dart';
import 'package:my_portfolio/screens/home/sections/resume_section/widgets/resume_section_experience.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      child: ResponsiveLayout(
        child: Column(
          children: [
            SectionTitle(
              title: t.resume.title,
              subtitle: t.resume.subtitle,
            ),
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SubsectionHeader(
                    title: t.resume.experience_title,
                    icon: Icons.work_outline,
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(
                    ResumeSectionData.resumes.length,
                    (index) => ResumeSectionExperienceTimelineItem(
                      resume: ResumeSectionData.resumes[index],
                      isLast: index == ResumeSectionData.resumes.length - 1,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _SubsectionHeader(
                    title: t.resume.education_title,
                    icon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(
                    EducationData.educations.length,
                    (index) => ResumeSectionEducationTimelineItem(
                      education: EducationData.educations[index],
                      isLast: index == EducationData.educations.length - 1,
                    ),
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SubsectionHeader(
                          title: t.resume.experience_title,
                          icon: Icons.work_outline,
                        ),
                        const SizedBox(height: 24),
                        ...List.generate(
                          ResumeSectionData.resumes.length,
                          (index) => ResumeSectionExperienceTimelineItem(
                            resume: ResumeSectionData.resumes[index],
                            isLast:
                                index == ResumeSectionData.resumes.length - 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 64),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SubsectionHeader(
                          title: t.resume.education_title,
                          icon: Icons.school_outlined,
                        ),
                        const SizedBox(height: 24),
                        ...List.generate(
                          EducationData.educations.length,
                          (index) => ResumeSectionEducationTimelineItem(
                            education: EducationData.educations[index],
                            isLast:
                                index == EducationData.educations.length - 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 48),
            const ResumeSectionDownloadResumeButton(),
          ],
        ),
      ),
    );
  }
}

class _SubsectionHeader extends StatelessWidget {
  const _SubsectionHeader({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Icon(icon, size: 24, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
