import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_theme.dart';

class BerberaPage extends StatefulWidget {
  const BerberaPage({super.key});

  @override
  State<BerberaPage> createState() => _BerberaPageState();
}

class _BerberaPageState extends State<BerberaPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final Map<String, List<Map<String, dynamic>>> _feedbackData = {
    'Berbera Beach Resort': [
      {
        'user': 'Amina K.',
        'rating': 5,
        'comment': 'Beautiful beachfront location with amazing views!',
        'date': '2024-01-15',
        'reply': 'Thank you Amina! We\'re glad you enjoyed the beach views. - Resort Management'
      },
      {
        'user': 'Khalid M.',
        'rating': 4,
        'comment': 'Great seafood and friendly staff.',
        'date': '2024-01-10',
        'reply': 'Thank you for your feedback Khalid! - Resort Staff'
      }
    ],
    'Berbera Port Services': [
      {
        'user': 'Omar S.',
        'rating': 4,
        'comment': 'Efficient port services and good communication.',
        'date': '2024-01-12',
        'reply': 'Thank you Omar! We appreciate your review. - Port Team'
      }
    ]
  };

  // Hotel data
  final List<Map<String, dynamic>> _hotels = [
    {
      'name': 'Berbera Beach Resort',
      'description': 'Luxury beachfront resort with stunning views of the Gulf of Aden.',
      'price': '\$120/night',
      'rating': '4.9',
      'address': 'Beach Road, Berbera',
      'contact': '+252 63 4567890',
      'website': 'https://berberabeachresort.com',
      'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'amenities': ['Beach Access', 'Pool', 'Restaurant', 'Spa', 'Water Sports', 'Wi-Fi'],
    },
    {
      'name': 'Damal Hotel Berbera',
      'description': 'Modern hotel near the port with business facilities and comfortable rooms.',
      'price': '\$75/night',
      'rating': '4.6',
      'address': 'Port District, Berbera',
      'contact': '+252 63 4455666',
      'website': 'https://www.damalhotels.com',
      'image': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'amenities': ['Wi-Fi', 'Restaurant', 'Business Center', 'Conference Room', 'Airport Shuttle'],
    },
    {
      'name': 'Port View Hotel',
      'description': 'Cozy hotel with panoramic views of the historic port.',
      'price': '\$60/night',
      'rating': '4.3',
      'address': 'Harbor Street, Berbera',
      'contact': '+252 63 4567891',
      'website': 'https://portviewberbera.com',
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      'amenities': ['Port View', 'Restaurant', 'Bar', 'Wi-Fi', 'Local Tours'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Header with Berbera Image
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'BERBERA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  FutureBuilder<String?>(
                    future: _firstExistingAsset([
                      'assets/images/image/berbera.jpeg',
                      'assets/images/image/berbera.jpg',
                      'assets/images/image/berbera.png',
                      'assets/images/berbera_cover.jpg',
                      'assets/images/berbera_cover.jpeg',
                      'assets/images/berbera_cover.png',
                    ]),
                    builder: (context, snapshot) {
                      final path = snapshot.data;
                      if (path != null) {
                        return Image.asset(path, fit: BoxFit.cover);
                      }
                      return Container(
                        color: Colors.grey[800],
                        child: const Center(child: Icon(Icons.beach_access, size: 100, color: Colors.white)),
                      );
                    },
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppTheme.withOpacity(Colors.black, 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Port Badge
                  Positioned(
                    top: 100,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'PORT CITY',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Beach Activities Section
                  _buildSectionHeader('Beach Activities', Icons.beach_access),
                  const SizedBox(height: 16),
                  _buildBeachActivitiesSection(),

                  const SizedBox(height: 30),

                  // Port Services Section
                  _buildSectionHeader('Port Services', Icons.anchor),
                  const SizedBox(height: 16),
                  _buildPortServicesSection(),

                  const SizedBox(height: 30),

                  // Hotels Section
                  _buildSectionHeader('Top Hotels & Accommodations', Icons.hotel),
                  const SizedBox(height: 16),
                  _buildHotelsSection(),

                  const SizedBox(height: 30),

                  // Feedback Section
                  _buildSectionHeader('Guest Reviews & Feedback', Icons.rate_review),
                  const SizedBox(height: 16),
                  _buildFeedbackSection(),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> _firstExistingAsset(List<String> assetPaths) async {
    for (final path in assetPaths) {
      if (await _assetExists(path)) return path;
    }
    return null;
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
        const SizedBox(width: 12),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBeachActivitiesSection() {
    final activities = [
      {
        'name': 'Swimming & Beach Sports',
        'description': 'Enjoy the beautiful beaches of Berbera with swimming, beach volleyball, and water sports.',
        'price': 'Free - \$15',
        'image': 'https://images.unsplash.com/photo-1530549387789-4c1017266635?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
      },
      {
        'name': 'Fishing Tours',
        'description': 'Experience traditional fishing with local fishermen along the Berbera coastline.',
        'price': '\$25 - \$50',
        'image': 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
      }
    ];

    return Column(
      children: activities.map((activity) => _buildActivityCard(activity)).toList(),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.withOpacity(Colors.black, 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 200,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.beach_access, size: 48, color: Colors.grey),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        activity['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        activity['price'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  activity['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Book Activity'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortServicesSection() {
    final services = [
      {
        'name': 'Berbera Port Authority',
        'description': 'Main port services including cargo handling, ship maintenance, and maritime logistics.',
        'contact': '+252 63 456 7890',
        'image': 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
      }
    ];

    return Column(
      children: services.map((service) => _buildServiceCard(service)).toList(),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.withOpacity(Colors.black, 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 200,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.anchor, size: 48, color: Colors.grey),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  service['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      service['contact'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Contact Service'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelsSection() {
    return Column(
      children: _hotels.map((hotel) => _buildHotelCard(hotel)).toList(),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.withOpacity(Colors.black, 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 200,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.hotel, size: 48, color: Colors.grey),
            ),
          ),
          
          // Hotel Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hotel['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hotel['price'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Rating
                Row(
                  children: [
                    Icon(Icons.star, size: 18, color: Colors.amber[600]),
                    const SizedBox(width: 6),
                    Text(
                      '${hotel['rating']} Rating',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Description
                Text(
                  hotel['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Contact Info
                _buildContactInfo(Icons.location_on, hotel['address']),
                _buildContactInfo(Icons.phone, hotel['contact']),
                _buildContactInfo(Icons.language, hotel['website']),
                
                const SizedBox(height: 16),
                
                // Amenities
                Text(
                  'Amenities:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: hotel['amenities'].map<Widget>((amenity) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        amenity,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showHotelDetails(hotel),
                        icon: const Icon(Icons.info_outline),
                        label: const Text('View Details'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showFeedbackDialog(hotel['name']),
                        icon: const Icon(Icons.rate_review),
                        label: const Text('Write Review'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHotelDetails(Map<String, dynamic> hotel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(hotel['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${hotel['address']}'),
            Text('Contact: ${hotel['contact']}'),
            Text('Website: ${hotel['website']}'),
            Text('Price: ${hotel['price']}'),
            const SizedBox(height: 8),
            Text('Description: ${hotel['description']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showFeedbackDialog(hotel['name']);
            },
            child: const Text('Write Review'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(String businessName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Write Review for $businessName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: 'Your Review',
                hintText: 'Share your experience...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement feedback submission
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for your feedback!')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.withOpacity(Colors.black, 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          
          ..._feedbackData.entries.map((entry) {
            final businessName = entry.key;
            final feedbacks = entry.value;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  businessName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                
                ...feedbacks.map((feedback) => _buildFeedbackCard(feedback)),
                const SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(Map<String, dynamic> feedback) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                feedback['user'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < feedback['rating'] ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber[600],
                    );
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          Text(
            feedback['comment'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            feedback['date'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          
          if (feedback['reply'] != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Reply:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    feedback['reply'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
