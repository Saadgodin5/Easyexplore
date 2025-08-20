class SomalilandCity {
  final String name;
  final String region;
  final List<String> alsoKnownAs;
  final String bio;
  final List<SomalilandHotel> topHotels;
  final CityDetails details;
  final List<String> attractions;
  final List<String> activities;
  final ClimateInfo climate;
  final TransportationInfo transportation;
  final SafetyInfo safety;

  SomalilandCity({
    required this.name,
    required this.region,
    this.alsoKnownAs = const [],
    required this.bio,
    required this.topHotels,
    required this.details,
    required this.attractions,
    required this.activities,
    required this.climate,
    required this.transportation,
    required this.safety,
  });

  factory SomalilandCity.fromJson(Map<String, dynamic> json) {
    return SomalilandCity(
      name: json['name'],
      region: json['region'],
      alsoKnownAs: List<String>.from(json['alsoKnownAs'] ?? []),
      bio: json['bio'],
      topHotels: (json['topHotels'] as List)
          .map((hotel) => SomalilandHotel.fromJson(hotel))
          .toList(),
      details: CityDetails.fromJson(json['details'] ?? {}),
      attractions: List<String>.from(json['attractions'] ?? []),
      activities: List<String>.from(json['activities'] ?? []),
      climate: ClimateInfo.fromJson(json['climate'] ?? {}),
      transportation: TransportationInfo.fromJson(json['transportation'] ?? {}),
      safety: SafetyInfo.fromJson(json['safety'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'alsoKnownAs': alsoKnownAs,
      'bio': bio,
      'topHotels': topHotels.map((hotel) => hotel.toJson()).toList(),
      'details': details.toJson(),
      'attractions': attractions,
      'activities': activities,
      'climate': climate.toJson(),
      'transportation': transportation.toJson(),
      'safety': safety.toJson(),
    };
  }
}

class SomalilandHotel {
  final String name;
  final String whyFamous;
  final List<String> amenities;
  final HotelContact contact;
  final List<String> sources;

  SomalilandHotel({
    required this.name,
    required this.whyFamous,
    required this.amenities,
    required this.contact,
    required this.sources,
  });

  factory SomalilandHotel.fromJson(Map<String, dynamic> json) {
    return SomalilandHotel(
      name: json['name'],
      whyFamous: json['whyFamous'],
      amenities: List<String>.from(json['amenities']),
      contact: HotelContact.fromJson(json['contact']),
      sources: List<String>.from(json['sources']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'whyFamous': whyFamous,
      'amenities': amenities,
      'contact': contact.toJson(),
      'sources': sources,
    };
  }
}

class HotelContact {
  final String? site;
  final String? phone;
  final String? page;
  final String? instaTag;
  final String? instagramLocation;
  final String? maps;
  final String? note;

  HotelContact({
    this.site,
    this.phone,
    this.page,
    this.instaTag,
    this.instagramLocation,
    this.maps,
    this.note,
  });

  factory HotelContact.fromJson(Map<String, dynamic> json) {
    return HotelContact(
      site: json['site'],
      phone: json['phone'],
      page: json['page'],
      instaTag: json['insta_tag'],
      instagramLocation: json['instagram_location'],
      maps: json['maps'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site': site,
      'phone': phone,
      'page': page,
      'insta_tag': instaTag,
      'instagram_location': instagramLocation,
      'maps': maps,
      'note': note,
    };
  }
}

class TravelPracticalities {
  final GettingIn gettingIn;
  final Money money;
  final Connectivity connectivity;
  final WhenToGo whenToGo;

  TravelPracticalities({
    required this.gettingIn,
    required this.money,
    required this.connectivity,
    required this.whenToGo,
  });

  factory TravelPracticalities.fromJson(Map<String, dynamic> json) {
    return TravelPracticalities(
      gettingIn: GettingIn.fromJson(json['gettingIn']),
      money: Money.fromJson(json['money']),
      connectivity: Connectivity.fromJson(json['connectivity']),
      whenToGo: WhenToGo.fromJson(json['whenToGo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gettingIn': gettingIn.toJson(),
      'money': money.toJson(),
      'connectivity': connectivity.toJson(),
      'whenToGo': whenToGo.toJson(),
    };
  }
}

class GettingIn {
  final List<Airport> airports;
  final VisaInfo visa;

  GettingIn({
    required this.airports,
    required this.visa,
  });

  factory GettingIn.fromJson(Map<String, dynamic> json) {
    return GettingIn(
      airports: (json['airports'] as List)
          .map((airport) => Airport.fromJson(airport))
          .toList(),
      visa: VisaInfo.fromJson(json['visa']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airports': airports.map((airport) => airport.toJson()).toList(),
      'visa': visa.toJson(),
    };
  }
}

class Airport {
  final String name;
  final String notes;
  final List<String> sources;

  Airport({
    required this.name,
    required this.notes,
    required this.sources,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      name: json['name'],
      notes: json['notes'],
      sources: List<String>.from(json['sources']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'sources': sources,
    };
  }
}

class VisaInfo {
  final String summary;
  final List<String> helpfulLinks;
  final String caution;

  VisaInfo({
    required this.summary,
    required this.helpfulLinks,
    required this.caution,
  });

  factory VisaInfo.fromJson(Map<String, dynamic> json) {
    return VisaInfo(
      summary: json['summary'],
      helpfulLinks: List<String>.from(json['helpfulLinks']),
      caution: json['caution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'helpfulLinks': helpfulLinks,
      'caution': caution,
    };
  }
}

class Money {
  final String currency;
  final String tip;
  final List<String> sources;

  Money({
    required this.currency,
    required this.tip,
    required this.sources,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      currency: json['currency'],
      tip: json['tip'],
      sources: List<String>.from(json['sources']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'tip': tip,
      'sources': sources,
    };
  }
}

class Connectivity {
  final String summary;

  Connectivity({
    required this.summary,
  });

  factory Connectivity.fromJson(Map<String, dynamic> json) {
    return Connectivity(
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
    };
  }
}

class WhenToGo {
  final String summary;
  final List<String> sources;

  WhenToGo({
    required this.summary,
    required this.sources,
  });

  factory WhenToGo.fromJson(Map<String, dynamic> json) {
    return WhenToGo(
      summary: json['summary'],
      sources: List<String>.from(json['sources']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'sources': sources,
    };
  }
}

// Additional city information classes
class CityDetails {
  final int population;
  final String timezone;
  final String language;
  final String currency;
  final List<String> languages;
  final String bestTimeToVisit;
  final String localCuisine;
  final String culturalNotes;

  CityDetails({
    required this.population,
    required this.timezone,
    required this.language,
    required this.currency,
    required this.languages,
    required this.bestTimeToVisit,
    required this.localCuisine,
    required this.culturalNotes,
  });

  factory CityDetails.fromJson(Map<String, dynamic> json) {
    return CityDetails(
      population: json['population'] ?? 0,
      timezone: json['timezone'] ?? '',
      language: json['language'] ?? '',
      currency: json['currency'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      bestTimeToVisit: json['bestTimeToVisit'] ?? '',
      localCuisine: json['localCuisine'] ?? '',
      culturalNotes: json['culturalNotes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'population': population,
      'timezone': timezone,
      'language': language,
      'currency': currency,
      'languages': languages,
      'bestTimeToVisit': bestTimeToVisit,
      'localCuisine': localCuisine,
      'culturalNotes': culturalNotes,
    };
  }
}

class ClimateInfo {
  final String climateType;
  final double averageTemperature;
  final String rainySeason;
  final String drySeason;
  final String bestTimeToVisit;
  final List<String> weatherNotes;

  ClimateInfo({
    required this.climateType,
    required this.averageTemperature,
    required this.rainySeason,
    required this.drySeason,
    required this.bestTimeToVisit,
    required this.weatherNotes,
  });

  factory ClimateInfo.fromJson(Map<String, dynamic> json) {
    return ClimateInfo(
      climateType: json['climateType'] ?? '',
      averageTemperature: (json['averageTemperature'] as num?)?.toDouble() ?? 0.0,
      rainySeason: json['rainySeason'] ?? '',
      drySeason: json['drySeason'] ?? '',
      bestTimeToVisit: json['bestTimeToVisit'] ?? '',
      weatherNotes: List<String>.from(json['weatherNotes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'climateType': climateType,
      'averageTemperature': averageTemperature,
      'rainySeason': rainySeason,
      'drySeason': drySeason,
      'bestTimeToVisit': bestTimeToVisit,
      'weatherNotes': weatherNotes,
    };
  }
}

class TransportationInfo {
  final String airportInfo;
  final String busInfo;
  final String taxiInfo;
  final String carRental;
  final List<String> localTransport;
  final String roadConditions;

  TransportationInfo({
    required this.airportInfo,
    required this.busInfo,
    required this.taxiInfo,
    required this.carRental,
    required this.localTransport,
    required this.roadConditions,
  });

  factory TransportationInfo.fromJson(Map<String, dynamic> json) {
    return TransportationInfo(
      airportInfo: json['airportInfo'] ?? '',
      busInfo: json['busInfo'] ?? '',
      taxiInfo: json['taxiInfo'] ?? '',
      carRental: json['carRental'] ?? '',
      localTransport: List<String>.from(json['localTransport'] ?? []),
      roadConditions: json['roadConditions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airportInfo': airportInfo,
      'busInfo': busInfo,
      'taxiInfo': taxiInfo,
      'carRental': carRental,
      'localTransport': localTransport,
      'roadConditions': roadConditions,
    };
  }
}

class SafetyInfo {
  final String safetyLevel;
  final List<String> safetyTips;
  final List<String> healthNotes;
  final String emergencyNumbers;
  final List<String> localCustoms;

  SafetyInfo({
    required this.safetyLevel,
    required this.safetyTips,
    required this.healthNotes,
    required this.emergencyNumbers,
    required this.localCustoms,
  });

  factory SafetyInfo.fromJson(Map<String, dynamic> json) {
    return SafetyInfo(
      safetyLevel: json['safetyLevel'] ?? '',
      safetyTips: List<String>.from(json['safetyTips'] ?? []),
      healthNotes: List<String>.from(json['healthNotes'] ?? []),
      emergencyNumbers: json['emergencyNumbers'] ?? '',
      localCustoms: List<String>.from(json['localCustoms'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'safetyLevel': safetyLevel,
      'safetyTips': safetyTips,
      'healthNotes': healthNotes,
      'emergencyNumbers': emergencyNumbers,
      'localCustoms': localCustoms,
    };
  }
}

class SomalilandGuide {
  final List<SomalilandCity> cities;
  final TravelPracticalities practicalities;

  SomalilandGuide({
    required this.cities,
    required this.practicalities,
  });

  factory SomalilandGuide.fromJson(Map<String, dynamic> json) {
    return SomalilandGuide(
      cities: (json['cities'] as List)
          .map((city) => SomalilandCity.fromJson(city))
          .toList(),
      practicalities: TravelPracticalities.fromJson(json['practicalities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cities': cities.map((city) => city.toJson()).toList(),
      'practicalities': practicalities.toJson(),
    };
  }
}
