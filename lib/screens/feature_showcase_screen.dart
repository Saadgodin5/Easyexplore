import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_management_provider.dart';
import '../providers/social_provider.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';

class FeatureShowcaseScreen extends StatefulWidget {
  const FeatureShowcaseScreen({super.key});

  @override
  State<FeatureShowcaseScreen> createState() => _FeatureShowcaseScreenState();
}

class _FeatureShowcaseScreenState extends State<FeatureShowcaseScreen> {
  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚀 Advanced Features Showcase'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Advanced Features Implemented!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Flutter app now has enterprise-level features',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Feature Categories
            _buildFeatureCategory(
              '🔧 Provider Management System',
              [
                'Advanced dashboard with analytics',
                'Destination management (CRUD operations)',
                'Booking management and status updates',
                'Revenue tracking and performance insights',
                'Provider verification system',
              ],
              Icons.business,
              Colors.blue,
            ),
            
            const SizedBox(height: 24),
            
            _buildFeatureCategory(
              '🌟 Enhanced User Experience & Navigation',
              [
                'Tabbed navigation with smooth transitions',
                'Responsive design for all screen sizes',
                'Modern Material Design 3 components',
                'Intuitive user flows and interactions',
                'Loading states and error handling',
              ],
                             Icons.auto_awesome,
              Colors.green,
            ),
            
            const SizedBox(height: 24),
            
            _buildFeatureCategory(
              '📊 Content & Data Management',
              [
                'Dynamic content loading and caching',
                'Real-time data updates with providers',
                'Image management and optimization',
                'Category-based content organization',
                'Search and filtering capabilities',
              ],
              Icons.storage,
              Colors.orange,
            ),
            
            const SizedBox(height: 24),
            
            _buildFeatureCategory(
              '💬 Social Features',
              [
                'Review and rating system',
                'Comment and discussion threads',
                'Like/unlike functionality',
                'User-generated content',
                'Social interactions and engagement',
              ],
              Icons.people,
              Colors.purple,
            ),
            
            const SizedBox(height: 24),
            
            _buildFeatureCategory(
              '🚀 Advanced Features',
              [
                'State management with Provider pattern',
                'Mock data system for MVP development',
                'Analytics and performance tracking',
                'Multi-role user system (Tourist/Provider)',
                'Extensible architecture for future growth',
              ],
              Icons.psychology,
              Colors.red,
            ),
            
            const SizedBox(height: 32),
            
            // Demo Buttons
            _buildDemoSection(),
            
            const SizedBox(height: 32),
            
            // Technical Details
            _buildTechnicalDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCategory(String title, List<String> features, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          ...features.map((feature) => 
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎯 Try the Features',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    // Navigate to provider dashboard
                    Navigator.pushNamed(context, '/provider-dashboard');
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dashboard),
                      SizedBox(width: 8),
                      Text('Provider Dashboard'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    // Show social features demo
                    _showSocialFeaturesDemo();
                  },
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 8),
                      Text('Social Features'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⚙️ Technical Implementation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildTechDetail('Architecture', 'Provider Pattern with ChangeNotifier'),
          _buildTechDetail('State Management', 'Centralized state with multiple providers'),
          _buildTechDetail('Data Models', 'Comprehensive model classes with JSON serialization'),
          _buildTechDetail('UI Components', 'Custom widgets and Material Design 3'),
          _buildTechDetail('Navigation', 'Tab-based navigation with smooth transitions'),
          _buildTechDetail('Error Handling', 'Comprehensive error handling and user feedback'),
          _buildTechDetail('Performance', 'Optimized rendering and efficient state updates'),
        ],
      ),
    );
  }

  Widget _buildTechDetail(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSocialFeaturesDemo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('💬 Social Features Demo'),
        content: Consumer<SocialProvider>(
          builder: (context, socialProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Reviews: ${socialProvider.reviews.length}'),
                Text('Total Comments: ${socialProvider.comments.length}'),
                const SizedBox(height: 16),
                const Text('Features Available:'),
                const Text('• Review system with ratings'),
                const Text('• Comment threads'),
                const Text('• Like/unlike functionality'),
                const Text('• User engagement metrics'),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
