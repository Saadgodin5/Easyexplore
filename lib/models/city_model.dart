class City {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String region;
  final List<String> highlights;

  City({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.region,
    required this.highlights,
  });
}

// Predefined cities for Somaliland
class SomalilandCities {
  static final List<City> cities = [
    City(
      id: 'hargeisa',
      name: 'Hargeisa',
      description: 'The capital and largest city of Somaliland, Hargeisa is a vibrant metropolis known for its bustling markets, modern infrastructure, and rich cultural heritage. The city serves as the economic and political center of the region.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      region: 'Maroodi Jeex',
      highlights: ['Central Market', 'Freedom Square', 'Hargeisa Cultural Center', 'Modern Architecture'],
    ),
    City(
      id: 'burco',
      name: 'Burco',
      description: 'A historic city in central Somaliland, Burco is famous for its traditional Somali culture, beautiful landscapes, and warm hospitality. The city is known for its agricultural activities and traditional crafts.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      region: 'Togdheer',
      highlights: ['Traditional Markets', 'Cultural Heritage', 'Agricultural Landscapes', 'Local Crafts'],
    ),
    City(
      id: 'gabiley',
      name: 'Gabiley',
      description: 'Located in the fertile Maroodi Jeex region, Gabiley is known for its agricultural prosperity and beautiful countryside. The city offers a peaceful atmosphere and stunning natural scenery.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      region: 'Maroodi Jeex',
      highlights: ['Fertile Farmlands', 'Countryside Views', 'Peaceful Atmosphere', 'Local Produce'],
    ),
    City(
      id: 'borama',
      name: 'Borama',
      description: 'The capital of Awdal region, Borama is a charming city known for its educational institutions, beautiful architecture, and rich cultural traditions. The city has a strong academic heritage.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      region: 'Awdal',
      highlights: ['Educational Centers', 'Cultural Heritage', 'Beautiful Architecture', 'Academic Tradition'],
    ),
    City(
      id: 'berbera',
      name: 'Berbera',
      description: 'A historic port city on the Gulf of Aden, Berbera is famous for its beautiful beaches, ancient architecture, and strategic maritime location. The city has a rich trading history.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      region: 'Sahil',
      highlights: ['Beautiful Beaches', 'Port Activities', 'Ancient Architecture', 'Maritime History'],
    ),
    City(
      id: 'cerigabo',
      name: 'Cerigabo',
      description: 'Located in the Sanaag region, Cerigabo is known for its stunning mountain landscapes, traditional culture, and outdoor adventure opportunities. The city offers breathtaking natural beauty.',
      imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
      region: 'Sanaag',
      highlights: ['Mountain Landscapes', 'Outdoor Adventures', 'Traditional Culture', 'Natural Beauty'],
    ),
  ];

  static City? getById(String id) {
    try {
      return cities.firstWhere((city) => city.id == id);
    } catch (e) {
      return null;
    }
  }
}








