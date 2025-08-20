import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
// Removed network image dependency while images are disabled
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import '../somaliland_travel_guide_screen.dart';
import 'explore_map_screen.dart';
import 'profile_screen.dart';
import 'category_details_page.dart';
import 'bookings_screen.dart';
import 'hargeisa_page.dart';
import 'berbera_page.dart';
import 'burco_page.dart';
import 'gabiley_page.dart';
import 'borama_page.dart';
import 'cerigabo_page.dart';
import 'search_screen.dart';
import '../../models/category_model.dart';
import '../../models/city_model.dart';
import '../../widgets/custom_button.dart';
import 'favorites_screen.dart';
import 'city_details_page.dart';

class TouristDashboard extends StatefulWidget {
  const TouristDashboard({super.key});

  @override
  State<TouristDashboard> createState() => _TouristDashboardState();
}

class _TouristDashboardState extends State<TouristDashboard> with TickerProviderStateMixin {
  int _selectedActivityIndex = 0; // 0: Swimming, 1: Diving, 2: Trekking
  final List<_Activity> _activities = const [
    _Activity('Swimming', Icons.pool, ''),
    _Activity('Diving', Icons.scuba_diving, ''),
    _Activity('Trekking', Icons.hiking, ''),
  ];

  List<City> _favoriteCities = [];
  bool _loadingFavorites = true;
  
  // City data; images will be resolved from local assets by name
  final List<_CityData> _cities = const [
    _CityData('Hargeisa', 'Somaliland'),
    _CityData('Berbera', 'Somaliland'),
    _CityData('Burco', 'Somaliland'),
    _CityData('Gabiley', 'Somaliland'),
    _CityData('Borama', 'Somaliland'),
    _CityData('Cerigabo', 'Somaliland'),
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorite_city_ids') ?? <String>[];
    final cities = ids.map((id) => SomalilandCities.getById(id)).whereType<City>().toList();
    if (!mounted) return;
    setState(() {
      _favoriteCities = cities;
      _loadingFavorites = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access user if needed later
    // final user = Provider.of<AuthProvider>(context).currentUser!;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Dashboard hero using Hargeisa cover asset when available (jpg or png)
                  FutureBuilder<String?>(
                    future: _firstExistingAsset([
                      'assets/images/hargeisa_cover.jpg',
                      'assets/images/hargeisa_cover.png',
                    ]),
                    builder: (context, snapshot) {
                      final String? path = snapshot.data;
                      if (path != null) {
                        return Image.asset(path, fit: BoxFit.cover);
                      }
                      return Container(
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Icon(Icons.landscape, size: 72, color: Colors.white70),
                      );
                    },
                  ),
                  // Dark overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                  // Search Bar
                  Positioned(
                    top: 100,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SearchScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'Where do you want to go?',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white),
                tooltip: 'Favorites',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // TODO: Implement notifications
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
          
          // Main Content
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Saved (Favorites) Section
                  if (!_loadingFavorites && _favoriteCities.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SAVED',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                              );
                              _loadFavorites();
                            },
                            child: const Text('View all'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
                        scrollDirection: Axis.horizontal,
                        itemCount: _favoriteCities.length.clamp(0, 10),
                        itemBuilder: (context, index) {
                          final city = _favoriteCities[index];
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => CityDetailsPage(city: city)),
                              );
                              _loadFavorites();
                            },
                            child: Container(
                              width: 130,
                              margin: EdgeInsets.only(right: index == _favoriteCities.length - 1 ? 0 : 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 90,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.photo, color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          city.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          city.region,
                                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  // Guest Mode Banner
                  if (Provider.of<AuthProvider>(context, listen: false).isGuestUser) ...[
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Guest Mode',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[700],
                                  ),
                                ),
                                Text(
                                  'You\'re exploring as a guest. Sign up to save your preferences and access all features.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Somaliland Categories Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOMALILAND CATEGORIES',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore the beauty and culture of Somaliland',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: SomalilandCategories.categories.length,
                          itemBuilder: (context, index) {
                            final category = SomalilandCategories.categories[index];
                            return _buildSomalilandCategoryCard(context, category);
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Somaliland Travel Guide Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.flag, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              'COMPLETE TRAVEL GUIDE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SomalilandTravelGuideScreen(),
                                ),
                              );
                            },
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.flag, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Explore Somaliland Travel Guide',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Popular Cities Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'POPULAR CITIES',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore the beautiful cities of Somaliland',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _cities.length,
                            itemBuilder: (context, index) {
                              final city = _cities[index];
                              return _buildSomalilandCityCard(city.name, '');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Recommended Routes (Somaliland)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.map, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              'RECOMMENDED ROUTES',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.info_outline, size: 18, color: Colors.grey),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                                                      boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Placeholder Somaliland map area (no network image)
                              Container(
                                color: Colors.grey[200],
                                child: const Center(child: Icon(Icons.map, size: 64, color: Colors.grey)),
                              ),
                              Positioned(
                                right: 12,
                                top: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                                                boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.schedule, size: 16),
                                      SizedBox(width: 6),
                                      Text('7 Days'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Best Activities with filters and animated hero image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.water_drop, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              'BEST ACTIVITIES',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(_activities.length, (index) {
                            final bool isSelected = index == _selectedActivityIndex;
                            final activity = _activities[index];
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: index == _activities.length - 1 ? 0 : 10),
                                child: GestureDetector(
                                  onTap: () => setState(() => _selectedActivityIndex = index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 220),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(activity.icon, size: 14, color: isSelected ? Colors.white : Colors.grey[700]),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            activity.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isSelected ? Colors.white : Colors.grey[800],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: Container(
                              key: ValueKey(_activities[_selectedActivityIndex].title),
                              height: 220,
                              width: double.infinity,
                              color: Colors.grey[200],
                              alignment: Alignment.center,
                              child: Icon(_activities[_selectedActivityIndex].icon, size: 64, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _activities[_selectedActivityIndex].title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Somaliland',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book_online),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExploreMapScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookingsScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildSomalilandCategoryCard(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryDetailsPage(category: category),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: category.color.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container - Smaller
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: category.color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: 14,
              ),
            ),
            
            const SizedBox(height: 6),
            
            // Category Name - Smaller font
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSomalilandCityCard(String cityName, String imageUrl) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          switch (cityName) {
            case 'Hargeisa':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HargeisaPage()),
              );
              break;
            case 'Berbera':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BerberaPage()),
              );
              break;
            case 'Burco':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BurcoPage()),
              );
              break;
            case 'Gabiley':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GabileyPage()),
              );
              break;
            case 'Borama':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BoramaPage()),
              );
              break;
            case 'Cerigabo':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CerigaboPage()),
              );
              break;
            default:
              _showCityInfo(context, cityName, imageUrl);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FutureBuilder<String?>(
                      future: _firstExistingAsset(_imageCandidatesForCity(cityName)),
                      builder: (context, snapshot) {
                        final path = snapshot.data;
                        if (path != null) {
                          return Image.asset(path, fit: BoxFit.cover);
                        }
                        return Container(
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Icon(Icons.image, color: Colors.grey),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cityName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _imageCandidatesForCity(String cityName) {
    final String lower = cityName.toLowerCase();
    // Keep Hargeisa dedicated cover (user already set)
    if (cityName == 'Hargeisa') {
      return [
        'assets/images/hargeisa_cover.jpg',
        'assets/images/hargeisa_cover.jpeg',
        'assets/images/hargeisa_cover.png',
        'assets/images/image/Hargeisa somaliland.jpeg',
      ];
    }

    final List<String> candidates = [
      // User-uploaded folder first
      'assets/images/image/${lower}.jpeg',
      'assets/images/image/${lower}.jpg',
      'assets/images/image/${lower}.png',
      // Project fallbacks
      'assets/images/${lower}_cover.jpg',
      'assets/images/${lower}_cover.jpeg',
      'assets/images/${lower}_cover.png',
    ];

    // Special filename cases found in assets/images/image/
    if (cityName == 'Cerigabo') {
      candidates.insertAll(0, [
        'assets/images/image/erigabo.jpeg',
        'assets/images/image/erigabo.jpg',
      ]);
    }
    if (cityName == 'Gabiley') {
      candidates.insert(0, 'assets/images/image/Gabiley.jpeg');
    }
    if (cityName == 'Berbera') {
      candidates.insert(0, 'assets/images/image/berbera.jpeg');
    }
    if (cityName == 'Borama') {
      candidates.insert(0, 'assets/images/image/borama.jpeg');
    }
    if (cityName == 'Burco') {
      candidates.insert(0, 'assets/images/image/burco.jpeg');
    }

    return candidates;
  }

  void _showCityInfo(BuildContext context, String cityName, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // City image header
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 48, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                cityName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to $cityName, one of the beautiful cities of Somaliland!',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'This city offers unique experiences and cultural heritage that make it a must-visit destination in Somaliland.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Explore',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }










}

extension _AssetCheck on _TouristDashboardState {
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
}

class _Activity {
  final String title;
  final IconData icon;
  final String imagePath;
  const _Activity(this.title, this.icon, this.imagePath);
  
  bool get isNetworkImage => imagePath.startsWith('http');
}

class _CityData {
  final String name;
  final String country;
  const _CityData(this.name, this.country);
}
