import 'package:flutter/material.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/skills_section.dart';
import 'sections/contact_section.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    if (index == 0) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
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

    _scrollController.animateTo(
      _scrollController.offset + offset.dy - 80,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
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
                key: _sectionKeys[0],
                child: HeroSection(
                  onExploreProjects: () => _scrollToSection(2),
                  onContact: () => _scrollToSection(5),
                ),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys[1],
                child: const AboutSection(),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys[2],
                child: const ProjectsSection(),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys[3],
                child: const ExperienceSection(),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys[4],
                child: const SkillsSection(),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys[5],
                child: const ContactSection(),
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
