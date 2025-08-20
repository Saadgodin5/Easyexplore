import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/somaliland_guide_provider.dart';
import '../models/somaliland_guide_model.dart';
import '../widgets/custom_button.dart';

class SomalilandTravelGuideScreen extends StatefulWidget {
  const SomalilandTravelGuideScreen({super.key});

  @override
  State<SomalilandTravelGuideScreen> createState() => _SomalilandTravelGuideScreenState();
}

class _SomalilandTravelGuideScreenState extends State<SomalilandTravelGuideScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedRegion = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize the guide provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SomalilandGuideProvider>().initialize();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Tab bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Theme.of(context).colorScheme.primary,
                          tabs: const [
              Tab(icon: Icon(Icons.location_city), text: 'Cities & Hotels'),
              Tab(icon: Icon(Icons.info), text: 'Practical Info'),
              Tab(icon: Icon(Icons.explore), text: 'City Details'),
            ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCitiesTab(),
                _buildPracticalInfoTab(),
                _buildCityDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
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
                    Icons.flag,
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
                        'Somaliland Travel Guide',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Discover 6 amazing cities with top hotels',
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
            
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search cities, hotels, or amenities...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitiesTab() {
    return Consumer<SomalilandGuideProvider>(
      builder: (context, guideProvider, child) {
        if (guideProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (guideProvider.guide == null) {
          return const Center(child: Text('Failed to load guide data'));
        }

        final cities = _filterCities(guideProvider.guide!.cities);
        final regions = guideProvider.getAllRegions();

        return Column(
          children: [
            // Region filter
            Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: _selectedRegion == 'All',
                      onSelected: (selected) {
                        setState(() {
                          _selectedRegion = 'All';
                        });
                      },
                      selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                      checkmarkColor: Theme.of(context).colorScheme.primary,
                    ),
                    ...regions.map((region) => 
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: FilterChip(
                          label: Text(region),
                          selected: _selectedRegion == region,
                          onSelected: (selected) {
                            setState(() {
                              _selectedRegion = region;
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Cities list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return _buildCityCard(city);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPracticalInfoTab() {
    return Consumer<SomalilandGuideProvider>(
      builder: (context, guideProvider, child) {
        if (guideProvider.guide == null) {
          return const Center(child: Text('Failed to load practical info'));
        }

        final practicalities = guideProvider.guide!.practicalities;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Getting In
              _buildPracticalitySection(
                'Getting In',
                Icons.flight,
                Colors.blue,
                [
                  _buildAirportInfo(practicalities.gettingIn.airports.first),
                  const SizedBox(height: 16),
                  _buildVisaInfo(practicalities.gettingIn.visa),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Money
              _buildPracticalitySection(
                'Money & Currency',
                Icons.attach_money,
                Colors.green,
                [
                  _buildMoneyInfo(practicalities.money),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Connectivity
              _buildPracticalitySection(
                'Connectivity',
                Icons.wifi,
                Colors.orange,
                [
                  _buildConnectivityInfo(practicalities.connectivity),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // When to Go
              _buildPracticalitySection(
                'When to Go',
                Icons.wb_sunny,
                Colors.red,
                [
                  _buildWhenToGoInfo(practicalities.whenToGo),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCityCard(SomalilandCity city) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
          // City header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${city.name} — ${city.region}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (city.alsoKnownAs.isNotEmpty)
                        Text(
                          'Also known as: ${city.alsoKnownAs.join(', ')}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // City bio
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              city.bio,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
          
          // Hotels section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.hotel,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Top Hotels',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                ...city.topHotels.map((hotel) => _buildHotelCard(hotel)),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHotelCard(SomalilandHotel hotel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hotel.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Text(
            hotel.whyFamous,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Amenities
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: hotel.amenities.map((amenity) => 
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  amenity,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ).toList(),
          ),
          
          const SizedBox(height: 12),
          
          // Contact info
          if (hotel.contact.site != null || hotel.contact.phone != null)
            Row(
              children: [
                if (hotel.contact.site != null) ...[
                                     CustomButton(
                     onPressed: () {
                       // Open website
                     },
                     backgroundColor: Colors.blue,
                     foregroundColor: Colors.white,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         const Icon(Icons.language, size: 16),
                         const SizedBox(width: 4),
                         const Text('Website'),
                       ],
                     ),
                   ),
                  const SizedBox(width: 8),
                ],
                                 if (hotel.contact.phone != null) ...[
                   CustomButton(
                     onPressed: () {
                       // Call phone
                     },
                     backgroundColor: Colors.green,
                     foregroundColor: Colors.white,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         const Icon(Icons.phone, size: 16),
                         const SizedBox(width: 4),
                         const Text('Call'),
                       ],
                     ),
                   ),
                 ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPracticalitySection(String title, IconData icon, Color color, List<Widget> children) {
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          ...children,
        ],
      ),
    );
  }

  Widget _buildAirportInfo(Airport airport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          airport.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          airport.notes,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildVisaInfo(VisaInfo visa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visa Information',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          visa.summary,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  visa.caution,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoneyInfo(Money money) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Currency',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          money.currency,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  money.tip,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnectivityInfo(Connectivity connectivity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Internet & Mobile',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          connectivity.summary,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildWhenToGoInfo(WhenToGo whenToGo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Climate & Best Time',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          whenToGo.summary,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCityDetailsTab() {
    return Consumer<SomalilandGuideProvider>(
      builder: (context, guideProvider, child) {
        if (guideProvider.guide == null) {
          return const Center(child: Text('Failed to load city details'));
        }

        final cities = guideProvider.guide!.cities;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: cities.length,
          itemBuilder: (context, index) {
            final city = cities[index];
            return _buildDetailedCityCard(city);
          },
        );
      },
    );
  }

  Widget _buildDetailedCityCard(SomalilandCity city) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: ExpansionTile(
        title: Text(
          '${city.name} — ${city.region}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          'Population: ${city.details.population.toString()} • ${city.details.timezone}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Info
                _buildInfoSection('Basic Information', [
                  'Language: ${city.details.language}',
                  'Currency: ${city.details.currency}',
                  'Best Time to Visit: ${city.details.bestTimeToVisit}',
                  'Local Cuisine: ${city.details.localCuisine}',
                ]),
                
                const SizedBox(height: 16),
                
                // Attractions
                _buildInfoSection('Top Attractions', city.attractions),
                
                const SizedBox(height: 16),
                
                // Activities
                _buildInfoSection('Popular Activities', city.activities),
                
                const SizedBox(height: 16),
                
                // Climate
                _buildInfoSection('Climate & Weather', [
                  'Type: ${city.climate.climateType}',
                  'Average Temperature: ${city.climate.averageTemperature}°C',
                  'Rainy Season: ${city.climate.rainySeason}',
                  'Dry Season: ${city.climate.drySeason}',
                  'Best Time: ${city.climate.bestTimeToVisit}',
                  ...city.climate.weatherNotes,
                ]),
                
                const SizedBox(height: 16),
                
                // Transportation
                _buildInfoSection('Transportation', [
                  city.transportation.airportInfo,
                  city.transportation.busInfo,
                  city.transportation.taxiInfo,
                  city.transportation.carRental,
                  'Road Conditions: ${city.transportation.roadConditions}',
                ]),
                
                const SizedBox(height: 16),
                
                // Safety
                _buildInfoSection('Safety & Health', [
                  'Safety Level: ${city.safety.safetyLevel}',
                  'Emergency: ${city.safety.emergencyNumbers}',
                  ...city.safety.safetyTips,
                  ...city.safety.healthNotes,
                ]),
                
                const SizedBox(height: 16),
                
                // Cultural Notes
                _buildInfoSection('Cultural Information', [
                  city.details.culturalNotes,
                  ...city.safety.localCustoms,
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: TextStyle(color: Colors.grey[600])),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  List<SomalilandCity> _filterCities(List<SomalilandCity> cities) {
    List<SomalilandCity> filtered = cities;
    
    // Filter by region
    if (_selectedRegion != 'All') {
      filtered = filtered.where((city) => city.region == _selectedRegion).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((city) {
        final query = _searchQuery.toLowerCase();
        return city.name.toLowerCase().contains(query) ||
               city.region.toLowerCase().contains(query) ||
               city.bio.toLowerCase().contains(query) ||
               city.topHotels.any((hotel) => 
                 hotel.name.toLowerCase().contains(query) ||
                 hotel.amenities.any((amenity) => amenity.toLowerCase().contains(query))
               );
      }).toList();
    }
    
    return filtered;
  }
}
