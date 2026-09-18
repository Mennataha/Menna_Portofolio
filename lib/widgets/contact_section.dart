import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  // دالة فتح الروابط
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. عنوان القسم
              Row(
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
                    'Contact',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Let's build something impactful together.",
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 40),

              // 2. شبكة كروت التواصل (Grid)
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  // Email Card
                  _buildContactCard(
                    context: context,
                    isDark: isDark,
                    isMobile: isMobile,
                    title: 'Email',
                    value: 'mentaha100@gmail.com', // استبدليه بإيميلك
                    icon: Icons.mail_outline_rounded,
                    onTap: () => _launchUrl('mailto:mentaha100@gmail.com'),
                  ),

                  // GitHub Card
                  _buildContactCard(
                    context: context,
                    isDark: isDark,
                    isMobile: isMobile,
                    title: 'GitHub',
                    value:
                        'https://github.com/Mennataha', // استبدليه برابط جيت هاب
                    icon: Icons.code_rounded,
                    onTap: () => _launchUrl('https://github.com/menna'),
                  ),

                  // LinkedIn Card
                  _buildContactCard(
                    context: context,
                    isDark: isDark,
                    isMobile: isMobile,
                    title: 'LinkedIn',
                    value:
                        'https://www.linkedin.com/in/menna-allah-taha-183071365?utm_source=share_via&utm_content=profile&utm_medium=member_android', // استبدليه برابط لينكد إن
                    icon: Icons.work_outline_rounded,
                    onTap: () => _launchUrl('https://linkedin.com/in/menna'),
                  ),

                  // Facebook Card
                  _buildContactCard(
                    context: context,
                    isDark: isDark,
                    isMobile: isMobile,
                    title: 'Facebook',
                    value:
                        'https://www.facebook.com/share/18yeVpMZX7/10:35 PM', // استبدليه برابط فيسبوك
                    icon: Icons.public_rounded,
                    onTap: () => _launchUrl('https://facebook.com/menna'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 3. كارت حالة العمل (Availability Card)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0D1B2A).withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business_center_outlined,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Availability',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Available for',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildBadge(context, 'Full-Time'),
                        _buildBadge(context, 'Part-Time'),
                        _buildBadge(context, 'Internship'),
                        _buildBadge(context, 'Freelance'),
                        _buildBadge(context, 'On Site'),
                        _buildBadge(context, 'Remote'),
                        _buildBadge(context, 'Hybrid'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // 4. الـ Footer في أسفل الصفحة
              Center(
                child: Text(
                  '© 2026 Menna • Flutter Developer & Software Engineer',
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // كارت التواصل الموحد
  Widget _buildContactCard({
    required BuildContext context,
    required bool isDark,
    required bool isMobile,
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final cardWidth = isMobile ? double.infinity : 480.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF0D1B2A).withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تصميم أزرار الحالة (Badges)
  Widget _buildBadge(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
