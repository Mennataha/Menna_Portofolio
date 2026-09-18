import 'dart:async';
import 'package:flutter/material.dart';

class CertificationSection extends StatefulWidget {
  const CertificationSection({super.key});

  @override
  State<CertificationSection> createState() => _CertificationSectionState();
}

class _CertificationSectionState extends State<CertificationSection> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  // قائمة الشهادات (يمكنك إضافة أو تعديل المسارات والعناوين بسهولة)
  final List<Map<String, String>> certificates = [
    {
      'title': 'Mobile Using Flutter',
      'issuer': 'ITI',
      'image': 'assets/images/iti.jpg', // استبدليها بمسار صورتك
    },
    {
      'title': 'inrtroduction to network',
      'issuer': 'Cisco',
      'image': 'assets/images/network.jpg',
    },
    {'title': 'CCNA', 'issuer': 'Cisco', 'image': 'assets/images/ccna.jpg'},
    {
      'title': 'Device Configration and Managment',
      'issuer': 'CERTIPORT',
      'image': 'assets/images/it.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.65);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && certificates.isNotEmpty) {
        _currentPage = (_currentPage + 1) % certificates.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. عنوان القسم
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
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
                  'CERTIFICATES',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // 2. الكاروسيل للتمرير الأفقي التلقائي
          SizedBox(
            height: 440,
            child: PageView.builder(
              controller: _pageController,
              itemCount: certificates.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final cert = certificates[index];
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
                    }
                    return Transform.scale(scale: value, child: child);
                  },
                  child: _buildCertificateCard(
                    theme: theme,
                    isDark: isDark,
                    title: cert['title']!,
                    issuer: cert['issuer']!,
                    imagePath: cert['image']!,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // 3. نقاط المؤشر (Dots Indicator)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              certificates.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // كارت الشهادة الأنيق
  Widget _buildCertificateCard({
    required ThemeData theme,
    required bool isDark,
    required String title,
    required String issuer,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0D1B2A).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // حاوي صورة الشهادة
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: isDark ? Colors.black26 : Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.08,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.workspace_premium_rounded,
                            size: 64,
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // التفاصيل أسفل الصورة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    issuer,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
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
}
