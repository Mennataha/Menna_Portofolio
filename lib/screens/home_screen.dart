import 'package:flutter/material.dart';

import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/education_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/certification_section.dart';
//import '../widgets/ai_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/projects_section.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final Map<String, GlobalKey> sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'education': GlobalKey(),
    'experience': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'certificates': GlobalKey(),
    'ai_assistant': GlobalKey(),
    'contact': GlobalKey(),
  };

  void scrollToSection(String section) {
    final key = sectionKeys[section];

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.1,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildBackground(context),

          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  key: sectionKeys['home'],
                  child: HeroSection(
                    onViewWork: () {
                      scrollToSection('projects');
                    },
                    onContact: () {
                      scrollToSection('contact');
                    },
                  ),
                ),

                Container(
                  key: sectionKeys['about'],
                  child: const AboutSection(),
                ),

                Container(
                  key: sectionKeys['education'],
                  child: const EducationSection(),
                ),

                Container(
                  key: sectionKeys['experience'],
                  child: const ExperienceSection(),
                ),

                Container(
                  key: sectionKeys['skills'],
                  child: const SkillsSection(),
                ),
                Container(
                  key: sectionKeys['projects'],
                  child: const ProjectsSection(),
                ),

                Container(
                  key: sectionKeys['certificates'],
                  child: const CertificationSection(),
                ),

                /*Container(
                  key: sectionKeys['ai_assistant'],
                  child: const AiSection(),
                ),*/
                Container(
                  key: sectionKeys['contact'],
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavbar(
              isDarkMode: widget.isDarkMode,
              onThemeToggle: widget.onThemeToggle,
              onItemTap: scrollToSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final theme = Theme.of(context);

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 120,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.025),
              ),
            ),
          ),
          Positioned(
            top: 500,
            right: -180,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.025),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
