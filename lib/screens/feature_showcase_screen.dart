import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_management_provider.dart';
import '../providers/social_provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import 'tourist/tourist_dashboard.dart';
import 'provider/provider_dashboard.dart';
import 'auth/login_screen.dart';

class FeatureShowcaseScreen extends StatefulWidget {
  const FeatureShowcaseScreen({super.key});

  @override
  State<FeatureShowcaseScreen> createState() => _FeatureShowcaseScreenState();
}

class _FeatureShowcaseScreenState extends State<FeatureShowcaseScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentFeatureIndex = 0;

  final List<FeatureSection> _features = [
    FeatureSection(
      title: '🗺️ Explore Somaliland',
      description: 'Discover 6 amazing cities with detailed travel guides',
      icon: Icons.map,
      color: Colors.blue,
      features: [
        'Hargeisa - Capital city with modern amenities',
        'Berbera - Historic port with beautiful beaches',
        'Burco - Cultural heart of Somaliland',
        'Gabiley - Agricultural paradise',
        'Borama - University town near Ethiopian border',
        'Cerigabo - Mountain retreat with stunning views',
      ],
    ),
    FeatureSection(
      title: '🏨 Smart Booking System',
      description: 'Book accommodations and services with ease',
      icon: Icons.hotel,
      color: Colors.green,
      features: [
        'Real-time availability checking',
        'Secure payment processing',
        'Booking confirmation & management',
        'Provider verification system',
        'Customer reviews and ratings',
        'Multi-language support',
      ],
    ),
    FeatureSection(
      title: '📅 Trip Planning',
      description: 'Plan your perfect itinerary with our smart tools',
      icon: Icons.schedule,
      color: Colors.orange,
      features: [
        'Day-by-day itinerary builder',
        'Activity recommendations',
        'Time and location optimization',
        'Weather-based suggestions',
        'Local transportation info',
        'Emergency contact integration',
      ],
    ),
    FeatureSection(
      title: '💬 Social Features',
      description: 'Connect with other travelers and share experiences',
      icon: Icons.people,
      color: Colors.purple,
      features: [
        'Review and rating system',
        'Photo sharing and galleries',
        'Travel tips and recommendations',
        'Community forums',
        'Local guide connections',
        'Cultural exchange opportunities',
      ],
    ),
    FeatureSection(
      title: '🎯 Provider Tools',
      description: 'Advanced tools for tourism service providers',
      icon: Icons.business,
      color: Colors.teal,
      features: [
        'Comprehensive dashboard analytics',
        'Booking management system',
        'Revenue tracking and reports',
        'Customer relationship management',
        'Marketing tools and promotions',
        'Performance insights',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    // Initialize providers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderManagementProvider>().initializeProvider(
        User(
          id: 'provider1',
          email: 'provider@example.com',
          name: 'Tourism Provider',
          role: UserRole.provider,
          createdAt: DateTime.now(),
        ),
      );
      context.read<SocialProvider>().initialize();
    });

    // Auto-advance features
    _startFeatureCarousel();
  }

  void _startFeatureCarousel() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentFeatureIndex = (_currentFeatureIndex + 1) % _features.length;
        });
        _animationController.reset();
        _animationController.forward();
        _startFeatureCarousel();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Feature showcase
              Expanded(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildFeatureSection(_features[_currentFeatureIndex]),
                      ),
                    );
                  },
                ),
              ),
              
              // Feature indicators
              _buildFeatureIndicators(),
              
              // Action buttons
              _buildActionButtons(),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ExploreEase',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your Smart Travel Companion',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Feature counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Feature ${_currentFeatureIndex + 1} of ${_features.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSection(FeatureSection feature) {
    return CustomCard(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Feature icon and title
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: feature.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  feature.icon,
                  color: feature.color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      feature.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Feature list
          ...feature.features.map((featureItem) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: feature.color,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    featureItem,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFeatureIndicators() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_features.length, (index) {
          final isActive = index == _currentFeatureIndex;
          return Container(
            width: isActive ? 24 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isActive 
                  ? Colors.white 
                  : Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Demo buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    _showDemo('tourist');
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.explore),
                      SizedBox(width: 8),
                      Text('Tourist Demo'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    _showDemo('provider');
                  },
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  foregroundColor: Colors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business),
                      SizedBox(width: 8),
                      Text('Provider Demo'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Main action buttons
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  borderColor: Colors.white,
                  foregroundColor: Colors.white,
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    final authProvider = context.read<AuthProvider>();
                    await authProvider.enterGuestMode();
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TouristDashboard(),
                        ),
                      );
                    }
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  child: const Text('Continue as Guest'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDemo(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${type == 'tourist' ? '🗺️' : '🏨'} ${type == 'tourist' ? 'Tourist' : 'Provider'} Demo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Experience the ${type} features:'),
            const SizedBox(height: 12),
            if (type == 'tourist') ...[
              const Text('• Explore Somaliland cities'),
              const Text('• Browse travel guides'),
              const Text('• Plan itineraries'),
              const Text('• Save favorites'),
              const Text('• Book accommodations'),
            ] else ...[
              const Text('• Manage bookings'),
              const Text('• Track revenue'),
              const Text('• Update services'),
              const Text('• View analytics'),
              const Text('• Customer management'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to appropriate dashboard
              if (type == 'tourist') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TouristDashboard(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProviderDashboard(),
                  ),
                );
              }
            },
            child: Text('Try ${type == 'tourist' ? 'Tourist' : 'Provider'} Mode'),
          ),
        ],
      ),
    );
  }
}

class FeatureSection {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> features;

  FeatureSection({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.features,
  });
}