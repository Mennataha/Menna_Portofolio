import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 850;

              return Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. صورة البروفايل بالدائرة الاحترافية والـ Glow الملون الشفاف
                  _buildProfileAvatar(isDark, theme),

                  SizedBox(width: isMobile ? 0 : 60, height: isMobile ? 50 : 0),

                  // 2. كارت النص الشفاف المعالج بالـ Glassmorphism
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: _buildBioCard(theme, isDark),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(bool isDark, ThemeData theme) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // التدرج الخارجي الشفاف المحيط بالصورة
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.5),
            theme.colorScheme.secondary.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF0D1B2A) : Colors.white,
        ),
        padding: const EdgeInsets.all(8), // مسافة شفافة بين الإطار والصورة
        child: ClipRRect(
          borderRadius: BorderRadius.circular(140),
          child: Image.asset(
            'assets/images/profile.jpg',
            fit: BoxFit.cover,
            alignment: Alignment(0.0, -0.4),
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(
                  Icons.person_rounded,
                  size: 100,
                  color: theme.colorScheme.primary,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBioCard(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // خلفية شفافة تتيح رؤية خلفية النجوم والجليد الخفيف
        color: isDark
            ? const Color(0xFF0D1B2A).withValues(alpha: 0.75)
            : Colors.white.withValues(alpha: 0.85),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                'ABOUT ME',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Ever since I was a little girl, I was always curious about mobile applications. I used to look at an app and wonder, “How was this made?” I dreamed of the day when I could open an app and say, “I built this.”',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Today, that little dream has become my passion.',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'I’m a Flutter Developer who enjoys turning ideas into simple, beautiful, and useful mobile applications. I care about creating clean UI/UX, smooth experiences, and reliable functionality that makes an application easy and enjoyable to use.',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'I also bring AI into mobile applications, adding smart features that make applications more helpful, adaptive, and innovative.',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'I’m always learning, improving my skills, and keeping up with new technologies. I believe good work is not only about writing code, but also about understanding the idea, paying attention to details, communicating clearly, and delivering on time.',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'For me, every project is more than just an application. It’s another idea brought to life.',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Let’s build something meaningful together.',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
