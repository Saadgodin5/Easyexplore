import 'package:flutter/material.dart';
import '../../models/destination_model.dart';

class ExploreMapScreen extends StatefulWidget {
  const ExploreMapScreen({super.key});

  @override
  State<ExploreMapScreen> createState() => _ExploreMapScreenState();
}

class _ExploreMapScreenState extends State<ExploreMapScreen> {
  final List<Destination> _destinations = [
    Destination(
      id: '1',
      name: 'Eiffel Tower',
      description: 'Iconic iron lattice tower on the Champ de Mars in Paris.',
      category: 'Landmark',
      rating: 4.5,
      reviewCount: 1250,
      images: ['https://example.com/eiffel.jpg'],
      location: Location(
        latitude: 48.8584,
        longitude: 2.2945,
        address: 'Champ de Mars, 5 Avenue Anatole France',
        city: 'Paris',
        country: 'France',
      ),
      price: 26.0,
      currency: 'EUR',
    ),
    Destination(
      id: '2',
      name: 'Louvre Museum',
      description: 'World\'s largest art museum and a historic monument.',
      category: 'Museum',
      rating: 4.7,
      reviewCount: 890,
      images: ['https://example.com/louvre.jpg'],
      location: Location(
        latitude: 48.8606,
        longitude: 2.3376,
        address: 'Rue de Rivoli',
        city: 'Paris',
        country: 'France',
      ),
      price: 17.0,
      currency: 'EUR',
    ),
    Destination(
      id: '3',
      name: 'Notre-Dame Cathedral',
      description: 'Medieval Catholic cathedral on the Île de la Cité.',
      category: 'Church',
      rating: 4.6,
      reviewCount: 756,
      images: ['https://example.com/notre-dame.jpg'],
      location: Location(
        latitude: 48.8530,
        longitude: 2.3499,
        address: '6 Parvis Notre-Dame - Pl. Jean-Paul II',
        city: 'Paris',
        country: 'France',
      ),
      price: 0.0,
      currency: 'EUR',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filters
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Placeholder
          Container(
            height: 300,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Interactive Map Coming Soon!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Google Maps integration will be added here',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement map view
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Map view will be implemented with Google Maps API'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('View Map'),
                  ),
                ],
              ),
            ),
          ),
          
          // Destinations List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _destinations.length,
              itemBuilder: (context, index) {
                final destination = _destinations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                      ),
                    ),
                    title: Text(
                      destination.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(destination.description),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber[600],
                            ),
                            const SizedBox(width: 4),
                            Text('${destination.rating} (${destination.reviewCount})'),
                            const SizedBox(width: 16),
                            Text(destination.category),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (destination.price != null && destination.price! > 0)
                          Text(
                            '${destination.currency} ${destination.price!.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        else
                          const Text(
                            'Free',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Navigate to destination detail
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Viewing ${destination.name}'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            minimumSize: const Size(0, 28),
                          ),
                          child: const Text('View'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
