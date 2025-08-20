import 'package:flutter/material.dart';
import '../../models/destination_model.dart';
import 'destination_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedLocation = 'All';
  String _selectedPriceRange = 'All';
  
  // Mock data for demonstration
  final List<Destination> _allDestinations = [
    Destination(
      id: '1',
      name: 'Hargeisa Cultural Tour',
      description: 'Explore the rich culture and history of Hargeisa',
      location: Location(
        latitude: 9.5616,
        longitude: 44.0670,
        address: 'Hargeisa City Center',
        city: 'Hargeisa',
        country: 'Somaliland',
      ),
      category: 'Culture',
      price: 25.0,
      rating: 4.5,
      reviewCount: 128,
      images: ['https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'],
    ),
    Destination(
      id: '2',
      name: 'Berbera Beach Adventure',
      description: 'Enjoy beautiful beaches and water activities',
      location: Location(
        latitude: 10.4340,
        longitude: 45.0140,
        address: 'Berbera Beach',
        city: 'Berbera',
        country: 'Somaliland',
      ),
      category: 'Adventure',
      price: 35.0,
      rating: 4.8,
      reviewCount: 95,
      images: ['https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'],
    ),
    Destination(
      id: '3',
      name: 'Burco Mountain Trek',
      description: 'Hike through scenic mountain trails',
      location: Location(
        latitude: 9.5221,
        longitude: 45.5336,
        address: 'Burco Mountains',
        city: 'Burco',
        country: 'Somaliland',
      ),
      category: 'Adventure',
      price: 45.0,
      rating: 4.6,
      reviewCount: 67,
      images: ['https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'],
    ),
    Destination(
      id: '4',
      name: 'Gabiley Nature Walk',
      description: 'Discover natural beauty and wildlife',
      location: Location(
        latitude: 9.6844,
        longitude: 43.6167,
        address: 'Gabiley Nature Reserve',
        city: 'Gabiley',
        country: 'Somaliland',
      ),
      category: 'Nature',
      price: 20.0,
      rating: 4.3,
      reviewCount: 89,
      images: ['https://images.unsplash.com/photo-1441974231531-c6227db76b6e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'],
    ),
    Destination(
      id: '5',
      name: 'Borama Historical Sites',
      description: 'Visit ancient historical landmarks',
      location: Location(
        latitude: 9.9344,
        longitude: 43.1806,
        address: 'Borama Historical District',
        city: 'Borama',
        country: 'Somaliland',
      ),
      category: 'Culture',
      price: 30.0,
      rating: 4.4,
      reviewCount: 73,
      images: ['https://images.unsplash.com/photo-1514565131-fce0801e5785?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'],
    ),
    Destination(
      id: '6',
      name: 'Cerigabo Desert Safari',
      description: 'Experience the vast desert landscape',
      location: Location(
        latitude: 11.2842,
        longitude: 48.6375,
        address: 'Cerigabo Desert',
        city: 'Cerigabo',
        country: 'Somaliland',
      ),
      category: 'Adventure',
      price: 55.0,
      rating: 4.7,
      reviewCount: 156,
      images: ['https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'],
    ),
  ];

  List<Destination> get _filteredDestinations {
    print('Search query: "$_searchQuery"');
    print('Selected category: $_selectedCategory');
    print('Selected location: $_selectedLocation');
    print('Selected price range: $_selectedPriceRange');
    
    final filtered = _allDestinations.where((destination) {
      bool matchesSearch = destination.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          destination.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          destination.location.city.toLowerCase().contains(_searchQuery.toLowerCase());
      
      bool matchesCategory = _selectedCategory == 'All' || destination.category == _selectedCategory;
      bool matchesLocation = _selectedLocation == 'All' || destination.location.city == _selectedLocation;
      
      bool matchesPrice = _selectedPriceRange == 'All' || (destination.price != null && _matchesPriceRange(destination.price!));
      
      final matches = matchesSearch && matchesCategory && matchesLocation && matchesPrice;
      print('Destination "${destination.name}": search=$matchesSearch, category=$matchesCategory, location=$matchesLocation, price=$matchesPrice, total=$matches');
      
      return matches;
    }).toList();
    
    print('Total filtered results: ${filtered.length}');
    return filtered;
  }

  bool _matchesPriceRange(double price) {
    switch (_selectedPriceRange) {
      case 'Under \$25':
        return price < 25;
      case '\$25 - \$50':
        return price >= 25 && price <= 50;
      case 'Over \$50':
        return price > 50;
      default:
        return true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Destinations'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search destinations, activities, or locations...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                print('Search text changed to: "$value"');
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Filters
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Category Filter
                _buildFilterChips(
                  'Category',
                  ['All', 'Culture', 'Adventure', 'Nature', 'History'],
                  _selectedCategory,
                  (value) {
                    print('Category changed to: $value');
                    setState(() => _selectedCategory = value);
                  },
                ),
                
                const SizedBox(height: 12),
                
                // Location Filter
                _buildFilterChips(
                  'Location',
                  ['All', 'Hargeisa', 'Berbera', 'Burco', 'Gabiley', 'Borama', 'Cerigabo'],
                  _selectedLocation,
                  (value) {
                    print('Location changed to: $value');
                    setState(() => _selectedLocation = value);
                  },
                ),
                
                const SizedBox(height: 12),
                
                // Price Filter
                _buildFilterChips(
                  'Price',
                  ['All', 'Under \$25', '\$25 - \$50', 'Over \$50'],
                  _selectedPriceRange,
                  (value) {
                    print('Price range changed to: $value');
                    setState(() => _selectedPriceRange = value);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${_filteredDestinations.length} results found',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (_filteredDestinations.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Implement sorting
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sorting options coming soon!')),
                      );
                    },
                    icon: const Icon(Icons.sort, size: 18),
                    label: const Text('Sort'),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Search Results
          Expanded(
            child: _filteredDestinations.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredDestinations.length,
                    itemBuilder: (context, index) {
                      final destination = _filteredDestinations[index];
                      return _buildDestinationCard(destination);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(String title, List<String> options, String selected, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final isSelected = option == selected;
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => onChanged(option),
              backgroundColor: Colors.grey[100],
                              selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[300]!,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDestinationCard(Destination destination) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DestinationDetailScreen(destination: destination),
              ),
            );
          },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Destination Image
                             ClipRRect(
                 borderRadius: BorderRadius.circular(8),
                 child: Container(
                   width: 80,
                   height: 80,
                   color: Colors.grey[300],
                   alignment: Alignment.center,
                   child: Icon(Icons.image, color: Colors.grey[600]),
                 ),
               ),
              
              const SizedBox(width: 16),
              
              // Destination Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          destination.location.city,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Row(
                      children: [
                        Icon(Icons.category, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          destination.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        // Rating
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber[600]),
                            const SizedBox(width: 4),
                            Text(
                              destination.rating.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        
                        const Spacer(),
                        
                        // Price
                        Text(
                          destination.price != null ? '\$${destination.price!.toStringAsFixed(0)}' : 'Price not set',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: destination.price != null ? Theme.of(context).colorScheme.primary : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No destinations found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
