import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_portfolio/app/widgets/nav_bar.dart';
import 'package:my_portfolio/app/widgets/scroll_fade_in.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/about_section.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/contact_section.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/hero_section/hero_section.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/projects_section/projects_section.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/resume_section/resume_section.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/skills_section/skills_section.dart';
import 'package:my_portfolio/gen/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final List<GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _sectionKeys = List.generate(6, (_) => GlobalKey());
    unawaited(_precacheProjectImages());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _precacheProjectImages() async {
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    final projects = Assets.lib.app.assets.images.projects.values;
    await Future.wait(
      projects.map(
        (img) => precacheImage(
          img.provider(),
          context,
          onError: (_, _) {},
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    if (index == 0) {
      unawaited(
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        ),
      );
      return;
    }

    final key = _sectionKeys[index];
    final renderObject = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderObject == null) return;

    final offset = renderObject.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );

    unawaited(
      _scrollController.animateTo(
        _scrollController.offset + offset.dy - 80,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  visibleThreshold: 0,
                  child: HeroSection(
                    key: _sectionKeys[0],
                    onExploreProjects: () => _scrollToSection(2),
                    onContact: () => _scrollToSection(5),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: AboutSection(key: _sectionKeys[1]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: ProjectsSection(key: _sectionKeys[2]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: ResumeSection(key: _sectionKeys[3]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: SkillsSection(key: _sectionKeys[4]),
                ),
              ),
              SliverToBoxAdapter(
                child: ScrollFadeIn(
                  child: ContactSection(key: _sectionKeys[5]),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              onSectionTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
