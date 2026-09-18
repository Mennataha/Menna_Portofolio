import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 700;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 60,
        vertical: 120,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SMALL INTRO
              Text(
                'HELLO, I\'M MENNA ALLAH TAHA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 17 : 19,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.5,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 22),

              // MAIN TITLE
              Text(
                'Flutter Developer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 42 : 68,
                  height: 1.05,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -1.5,
                ),
              ),

              const SizedBox(height: 18),

              // DESCRIPTION
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  'I build modern, user-focused mobile and web applications '
                  'with Flutter, enhanced by the power of AI.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 19,
                    height: 1.7,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),

              const SizedBox(height: 38),

              // BUTTONS
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  _heroButton(
                    context: context,
                    text: 'View My Work',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: onViewWork,
                    isPrimary: true,
                  ),
                  _heroButton(
                    context: context,
                    text: 'Contact Me',
                    icon: Icons.mail_outline_rounded,
                    onPressed: onContact,
                    isPrimary: true,
                  ),
                ],
              ),

              const SizedBox(height: 55),

              // SCROLL INDICATOR
              Column(
                children: [
                  Text(
                    'SCROLL TO EXPLORE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24,
                    color: theme.colorScheme.primary.withValues(alpha: 0.65),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    final theme = Theme.of(context);

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
