import 'dart:math';

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  bool isDarkMode = true;

  ThemeData get _darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF080812),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFA78BFA),
        secondary: Color(0xFF8B5CF6),
        surface: Color(0xFF14121F),
        onSurface: Color(0xFFF2EDF7),
        onPrimary: Color(0xFF160D20),
      ),
      fontFamily: 'Arial',
      useMaterial3: true,
    );
  }

  ThemeData get _lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF9F7FC),
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 115, 41, 241),
        secondary: Color(0xFFA78BFA),
        surface: Colors.white,
        onSurface: Color(0xFF211A2C),
        onPrimary: Colors.white,
      ),
      fontFamily: 'Arial',
      useMaterial3: true,
    );
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menna Taha | Flutter Developer',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: Stack(
        children: [
          const SpaceBackground(),

          HomeScreen(isDarkMode: isDarkMode, onThemeToggle: toggleTheme),
        ],
      ),
    );
  }
}

// ======================================================
// SPACE BACKGROUND
// ======================================================

class SpaceBackground extends StatelessWidget {
  const SpaceBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned.fill(
      child: CustomPaint(painter: SpacePainter(isDark: isDark)),
    );
  }
}

// ======================================================
// STARS PAINTER
// ======================================================

class SpacePainter extends CustomPainter {
  final bool isDark;

  SpacePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);

    // SUBTLE SPACE GRADIENT

    final backgroundPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.5),
        radius: 1.2,
        colors: isDark
            ? [
                const Color(0xFF111020),
                const Color(0xFF080812),
                const Color(0xFF05050C),
              ]
            : [
                const Color(0xFFFFFFFF),
                const Color(0xFFF9F7FC),
                const Color(0xFFF2EFF8),
              ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Offset.zero & size, backgroundPaint);

    // --------------------------------------------------
    // STARS
    // --------------------------------------------------

    final starPaint = Paint();

    final int starCount = isDark ? 180 : 80;

    for (int i = 0; i < starCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      final radius = random.nextDouble() * 1.1 + 0.25;

      final opacity = isDark
          ? random.nextDouble() * 0.45 + 0.15
          : random.nextDouble() * 0.15 + 0.05;

      starPaint.color = isDark
          ? Colors.white.withValues(alpha: opacity)
          : const Color(0xFF6D5A8D).withValues(alpha: opacity);

      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }

    // --------------------------------------------------
    // A FEW BRIGHTER STARS
    // --------------------------------------------------

    if (isDark) {
      final brightStarPaint = Paint();

      for (int i = 0; i < 18; i++) {
        final x = random.nextDouble() * size.width;
        final y = random.nextDouble() * size.height;

        brightStarPaint.color = Colors.white.withValues(alpha: 0.45);

        canvas.drawCircle(Offset(x, y), 1.2, brightStarPaint);

        // Small glow
        brightStarPaint.color = const Color(0xFFA78BFA).withValues(alpha: 0.08);

        canvas.drawCircle(Offset(x, y), 5, brightStarPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SpacePainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
