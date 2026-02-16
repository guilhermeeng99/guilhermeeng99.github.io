import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/widgets/nav_bar.dart';
import 'package:my_portfolio/app/widgets/scroll_fade_in.dart';
import 'package:my_portfolio/screens/home/sections/about_section.dart';
import 'package:my_portfolio/screens/home/sections/contact_section.dart';
import 'package:my_portfolio/screens/home/sections/experience_section/experience_section.dart';
import 'package:my_portfolio/screens/home/sections/hero_section/hero_section.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/projects_section.dart';
import 'package:my_portfolio/screens/home/sections/skills_section/skills_section.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final sectionKeys = useMemoized(() => List.generate(6, (_) => GlobalKey()));

    void scrollToSection(int index) {
      if (index == 0) {
        unawaited(
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
          ),
        );
        return;
      }

      final key = sectionKeys[index];
      final renderObject = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderObject == null) return;

      final offset = renderObject.localToGlobal(
        Offset.zero,
        ancestor: context.findRenderObject(),
      );

      unawaited(
        scrollController.animateTo(
          scrollController.offset + offset.dy - 80,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  visibleThreshold: 0,
                  child: HeroSection(
                    key: sectionKeys[0],
                    onExploreProjects: () => scrollToSection(2),
                    onContact: () => scrollToSection(5),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: AboutSection(key: sectionKeys[1]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: ProjectsSection(key: sectionKeys[2]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: ExperienceSection(key: sectionKeys[3]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: SkillsSection(key: sectionKeys[4]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: ContactSection(key: sectionKeys[5]),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: scrollController,
              onSectionTap: scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
