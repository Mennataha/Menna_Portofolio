import 'package:flutter/material.dart';

class PortfolioNavbar extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final Function(String) onItemTap;

  const PortfolioNavbar({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final bool isCompact = width < 1100;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 700 ? 20 : 35,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        children: [
          // LOGO
          Text(
            'MT.',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              letterSpacing: 1,
            ),
          ),

          const Spacer(),

          // FULL NAVBAR
          if (!isCompact) ...[
            _navItem('Home', 'home', theme),
            _navItem('About', 'about', theme),
            _navItem('Education', 'education', theme),
            _navItem('Experience', 'experience', theme),
            _navItem('Skills', 'skills', theme),
            _navItem('Projects', 'projects', theme),
            _navItem('Certificates', 'certificates', theme),
            //_navItem('AI Assistant', 'ai_assistant', theme),
            _navItem('Contact', 'contact', theme),

            const SizedBox(width: 10),
          ],

          // THEME BUTTON
          IconButton(
            onPressed: onThemeToggle,
            tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(isDarkMode),
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          // MENU BUTTON
          if (isCompact)
            IconButton(
              onPressed: () {
                _showMobileMenu(context);
              },
              tooltip: 'Menu',
              icon: Icon(
                Icons.menu_rounded,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, String section, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () => onItemTap(section),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 15, 10),
                  child: Row(
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                ),

                // SCROLLABLE MENU
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    children: [
                      _mobileItem(context, 'Home', Icons.home_outlined, 'home'),
                      _mobileItem(
                        context,
                        'About',
                        Icons.person_outline_rounded,
                        'about',
                      ),
                      _mobileItem(
                        context,
                        'Education',
                        Icons.school_outlined,
                        'education',
                      ),
                      _mobileItem(
                        context,
                        'Experience',
                        Icons.work_outline_rounded,
                        'experience',
                      ),
                      _mobileItem(
                        context,
                        'Skills',
                        Icons.code_rounded,
                        'skills',
                      ),
                      _mobileItem(
                        context,
                        'Projects',
                        Icons.folder_outlined,
                        'projects',
                      ),
                      _mobileItem(
                        context,
                        'Certificates',
                        Icons.workspace_premium_outlined,
                        'certificates',
                      ),
                      /*_mobileItem(
                        context,
                        'AI Assistant',
                        Icons.auto_awesome_outlined,
                        'ai_assistant', // كانت 'ai' وعدلناها إلى 'ai_assistant'
                      ),*/
                      _mobileItem(
                        context,
                        'Contact',
                        Icons.mail_outline_rounded,
                        'contact',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mobileItem(
    BuildContext context,
    String title,
    IconData icon,
    String section,
  ) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () {
        Navigator.pop(context);

        Future.delayed(const Duration(milliseconds: 200), () {
          onItemTap(section);
        });
      },
    );
  }
}
