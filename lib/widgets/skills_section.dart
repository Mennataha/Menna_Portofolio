import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 1. قائمة المهارات الأساسية
    final List<Map<String, dynamic>> skills = [
      {'title': 'Flutter', 'icon': Icons.flutter_dash_rounded},
      {'title': 'Dart', 'icon': Icons.code_rounded},
      {'title': 'Firebase', 'icon': Icons.local_fire_department_rounded},
      {'title': 'UI/UX', 'icon': Icons.palette_rounded},
      {'title': 'Clean Architecture', 'icon': Icons.architecture_rounded},
      {'title': 'OOP', 'icon': Icons.data_object_rounded},
      {'title': 'Databases', 'icon': Icons.storage_rounded},
      {'title': 'Problem Solving', 'icon': Icons.psychology_rounded},
      {'title': 'Software Architecture', 'icon': Icons.account_tree_rounded},
      {'title': 'AI Integration', 'icon': Icons.smart_toy_rounded},
      {'title': 'Prompt Engineering', 'icon': Icons.auto_awesome_rounded},
      {
        'title': 'Scalable & Well-Structured Software Design',
        'icon': Icons.layers_rounded,
      },
    ];

    // 2. قائمة الأدوات والتقنيات
    final List<Map<String, dynamic>> tools = [
      {'title': 'Git & GitHub', 'icon': Icons.merge_type_rounded},
      {'title': 'Figma', 'icon': Icons.design_services_rounded},
      {'title': 'Visual Studio Code', 'icon': Icons.terminal_rounded},
      {'title': 'Android Studio', 'icon': Icons.android_rounded},
      {'title': 'Firebase', 'icon': Icons.cloud_done_rounded},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- قسم SKILLS ---
              _buildSectionHeader(theme, 'SKILLS'),
              const SizedBox(height: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth < 600
                      ? 1
                      : constraints.maxWidth < 900
                      ? 2
                      : 3;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: 75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      return _buildSkillCard(
                        theme: theme,
                        isDark: isDark,
                        title: skills[index]['title'],
                        icon: skills[index]['icon'],
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 60),

              // --- قسم TOOLS & TECHNOLOGIES ---
              _buildSectionHeader(theme, 'TOOLS & TECHNOLOGIES'),
              const SizedBox(height: 12),
              Text(
                'Technologies I use to build, design, and ship products',
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                ),
              ),
              const SizedBox(height: 25),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: tools.map((tool) {
                  return _buildToolChip(
                    theme: theme,
                    isDark: isDark,
                    title: tool['title'],
                    icon: tool['icon'],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // هيدر القسم للشريط الجانبي
  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  // كارت المهارة (بطاقات المهارات الرئيسية)
  Widget _buildSkillCard({
    required ThemeData theme,
    required bool isDark,
    required String title,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0D1B2A).withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // إيقونة دائرية مع لمعة Glow خفيفة بنفس اللون
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, size: 22, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // كبسولات الأدوات والتقنيات (Tools Chips)
  Widget _buildToolChip({
    required ThemeData theme,
    required bool isDark,
    required String title,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0D1B2A).withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
