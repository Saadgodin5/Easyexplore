import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final String imageUrl;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.imageUrl,
    required this.color,
  });
}

// Predefined categories for Somaliland
class SomalilandCategories {
  static final List<Category> categories = [
    Category(
      id: 'historical',
      name: 'Historical Sites & Landmarks',
      icon: Icons.account_balance,
      description: 'Discover the rich history of Somaliland through ancient ruins, historical monuments, and significant landmarks that tell the story of this remarkable region.',
      imageUrl: 'assets/images/hargeisa_cover.jpg',
      color: Colors.blue,
    ),
    Category(
      id: 'nature',
      name: 'Nature & Adventure',
      icon: Icons.terrain,
      description: 'Explore the stunning natural landscapes of Somaliland, from rugged mountains and pristine beaches to wildlife sanctuaries and adventure activities.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.green,
    ),
    Category(
      id: 'culture',
      name: 'Culture & Events',
      icon: Icons.celebration,
      description: 'Immerse yourself in the vibrant culture of Somaliland through traditional festivals, cultural events, and authentic local experiences.',
      imageUrl: 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.purple,
    ),
    Category(
      id: 'food',
      name: 'Restaurants & Food',
      icon: Icons.restaurant,
      description: 'Savor the delicious flavors of Somaliland cuisine, from traditional Somali dishes to modern restaurants and street food experiences.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.orange,
    ),
    Category(
      id: 'accommodation',
      name: 'Accommodation',
      icon: Icons.hotel,
      description: 'Find comfortable places to stay in Somaliland, from luxury hotels to cozy guesthouses and traditional accommodations.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.indigo,
    ),
    Category(
      id: 'transportation',
      name: 'Transportation',
      icon: Icons.directions_bus,
      description: 'Navigate Somaliland easily with information about local transportation, including buses, taxis, and travel tips.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.teal,
    ),
    Category(
      id: 'shopping',
      name: 'Shops & Services',
      icon: Icons.store,
      description: 'Discover local markets, shops, and essential services in Somaliland for all your shopping and service needs.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.cyan,
    ),
    Category(
      id: 'emergency',
      name: 'Emergency & Health',
      icon: Icons.local_hospital,
      description: 'Access important emergency contacts, healthcare facilities, and safety information while in Somaliland.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.red,
    ),
    Category(
      id: 'religious',
      name: 'Religious & Spiritual Sites',
      icon: Icons.mosque,
      description: 'Visit sacred places and religious sites in Somaliland, including mosques and spiritual landmarks.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      color: Colors.brown,
    ),
  ];

  static Category? getById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }
}

