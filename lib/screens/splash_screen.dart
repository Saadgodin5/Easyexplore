import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';
import '../utils/app_theme.dart';
import 'tourist/tourist_dashboard.dart';
import 'provider/provider_dashboard.dart';
import 'auth/login_screen.dart';
import 'feature_showcase_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _colorAnimation = ColorTween(
      begin: AppTheme.primaryColor,
      end: AppTheme.secondaryColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
    ));

    _animationController.forward();

    // Navigate after animation
    Future.delayed(const Duration(seconds: 4), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isAuthenticated) {
      final user = authProvider.currentUser!;
      if (user.role == UserRole.tourist) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TouristDashboard()),
        );
      } else if (user.role == UserRole.provider) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ProviderDashboard()),
        );
      }
    } else {
      // Show feature showcase first, then auto enter guest mode
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const FeatureShowcaseScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _colorAnimation.value ?? AppTheme.primaryColor,
                  AppTheme.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Background Pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BackgroundPatternPainter(
                      animationValue: _animationController.value,
                    ),
                  ),
                ),
                
                // Main Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Logo/Icon with Animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.explore,
                              size: 60,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // App Name with Slide Animation
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
                        )),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'ExploreEase',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Tagline
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
                        )),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'Your Smart Travel Companion',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withValues(alpha: 0.9),
                              letterSpacing: 1.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Loading indicator with custom animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withValues(alpha: 0.8),
                            ),
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Loading text
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Loading amazing features...',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Feature badges (animated)
                Positioned(
                  top: 100,
                  left: 20,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _FeatureBadge(
                      icon: Icons.map,
                      label: 'Explore',
                      delay: 0.5,
                      animationController: _animationController,
                    ),
                  ),
                ),
                
                Positioned(
                  top: 100,
                  right: 20,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _FeatureBadge(
                      icon: Icons.hotel,
                      label: 'Book',
                      delay: 0.7,
                      animationController: _animationController,
                    ),
                  ),
                ),
                
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _FeatureBadge(
                      icon: Icons.schedule,
                      label: 'Plan',
                      delay: 0.9,
                      animationController: _animationController,
                    ),
                  ),
                ),
                
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _FeatureBadge(
                      icon: Icons.favorite,
                      label: 'Save',
                      delay: 1.1,
                      animationController: _animationController,
                    ),
                  ),
                ),
                
                // Skip button
                Positioned(
                  top: 60,
                  right: 20,
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return TextButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await authProvider.enterGuestMode();
                          if (mounted) {
                            navigator.pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const TouristDashboard(),
                              ),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Version info
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Version 1.0.0 • Built with ❤️ for Somaliland',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final double delay;
  final AnimationController animationController;

  const _FeatureBadge({
    required this.icon,
    required this.label,
    required this.delay,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final animationValue = Curves.easeOut.transform(
          (animationController.value - delay).clamp(0.0, 1.0),
        );
        
        return Transform.scale(
          scale: animationValue,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BackgroundPatternPainter extends CustomPainter {
  final double animationValue;

  _BackgroundPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw animated circles
    for (int i = 0; i < 5; i++) {
      final radius = 20 + (i * 15) * animationValue;
      final center = Offset(
        size.width * (0.2 + i * 0.15),
        size.height * (0.3 + i * 0.1),
      );
      
      canvas.drawCircle(center, radius, paint);
    }
    
    // Draw animated lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 3; i++) {
      final startY = size.height * (0.2 + i * 0.3);
      final endY = startY + 100 * animationValue;
      
      canvas.drawLine(
        Offset(0, startY),
        Offset(size.width, endY),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}