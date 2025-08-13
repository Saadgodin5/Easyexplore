class Destination {
  final String id;
  final String name;
  final String description;
  final String category;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final Location location;
  final Map<String, dynamic>? amenities;
  final bool isVerified;
  final String? providerId;
  final double? price;
  final String? currency;

  Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.location,
    this.amenities,
    this.isVerified = false,
    this.providerId,
    this.price,
    this.currency,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      images: List<String>.from(json['images']),
      location: Location.fromJson(json['location']),
      amenities: json['amenities'],
      isVerified: json['isVerified'] ?? false,
      providerId: json['providerId'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'rating': rating,
      'reviewCount': reviewCount,
      'images': images,
      'location': location.toJson(),
      'amenities': amenities,
      'isVerified': isVerified,
      'providerId': providerId,
      'price': price,
      'currency': currency,
    };
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  final String country;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'],
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'country': country,
    };
  }
}
