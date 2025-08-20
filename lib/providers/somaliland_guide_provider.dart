import 'package:flutter/material.dart';
import '../models/somaliland_guide_model.dart';

class SomalilandGuideProvider extends ChangeNotifier {
  SomalilandGuide? _guide;
  bool _isLoading = false;
  String? _error;

  SomalilandGuide? get guide => _guide;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void initialize() {
    _loadGuideData();
  }

  void _loadGuideData() {
    _isLoading = true;
    notifyListeners();

    try {
      // Create the comprehensive Somaliland guide data
      _guide = SomalilandGuide(
        cities: [
          // Hargeisa
          SomalilandCity(
            name: 'Hargeisa',
            region: 'Maroodi Jeex',
            alsoKnownAs: ['Hargeysa'],
            bio: 'Capital and largest city; administrative, commercial and cultural hub. Gateway to Laas Geel rock art; milder climate thanks to elevation.',
            details: CityDetails(
              population: 1200000,
              timezone: 'UTC+3',
              language: 'Somali',
              currency: 'SLSH & USD',
              languages: ['Somali', 'Arabic', 'English'],
              bestTimeToVisit: 'October to March',
              localCuisine: 'Camel meat, rice, pasta, fresh fruits',
              culturalNotes: 'Conservative Muslim society, dress modestly, respect local customs',
            ),
            attractions: [
              'Laas Geel Rock Art (UNESCO site)',
              'Hargeisa Cultural Center',
              'Freedom Square',
              'Central Market',
              'War Memorial',
              'Presidential Palace',
              'Hargeisa Zoo',
              'Sheikh Mountains',
            ],
            activities: [
              'Visit ancient rock art sites',
              'Explore local markets',
              'Cultural tours',
              'Mountain hiking',
              'Photography tours',
              'Local cuisine tasting',
              'Historical site visits',
              'Shopping for traditional crafts',
            ],
            climate: ClimateInfo(
              climateType: 'Semi-arid',
              averageTemperature: 25.0,
              rainySeason: 'April to June',
              drySeason: 'July to March',
              bestTimeToVisit: 'October to March (cooler, drier)',
              weatherNotes: [
                'Hot and dry most of the year',
                'Mild temperatures due to elevation (1,334m)',
                'Occasional dust storms',
                'Cooler evenings',
              ],
            ),
            transportation: TransportationInfo(
              airportInfo: 'Egal International Airport (HGA) - 5km from city center',
              busInfo: 'Local minibuses and shared taxis available',
              taxiInfo: 'Yellow taxis throughout the city, negotiate prices',
              carRental: 'Available at airport and major hotels',
              localTransport: ['Minibuses', 'Shared taxis', 'Private taxis', 'Walking'],
              roadConditions: 'Main roads paved, side streets may be rough',
            ),
            safety: SafetyInfo(
              safetyLevel: 'Generally safe for tourists',
              safetyTips: [
                'Avoid political demonstrations',
                'Dress conservatively',
                'Respect local customs',
                'Keep valuables secure',
                'Use registered taxis',
              ],
              healthNotes: [
                'Bring basic medical supplies',
                'Drink bottled water',
                'Use insect repellent',
                'Consider travel insurance',
              ],
              emergencyNumbers: 'Police: 999, Ambulance: 999, Fire: 999',
              localCustoms: [
                'Greet with "Salaam alaykum"',
                'Remove shoes before entering homes',
                'Use right hand for eating',
                'Respect prayer times',
              ],
            ),
            topHotels: [
              SomalilandHotel(
                name: 'Ambassador Hotel Hargeisa',
                whyFamous: 'One of the city\'s flagship properties; popular with business and NGO travelers.',
                amenities: ['Airport shuttle', 'Restaurant', 'Conference rooms', 'Wi-Fi'],
                contact: HotelContact(
                  site: 'https://ambassadorhotelhargeisa.com/',
                  phone: '+252 63 4454000',
                ),
                sources: ['https://ambassadorhotelhargeisa.com/'],
              ),
              SomalilandHotel(
                name: 'Maan-Soor (Maansoor) Hotel',
                whyFamous: 'Long-running Hargeisa staple with large grounds and events spaces.',
                amenities: ['Wi-Fi', 'Dining', 'Event halls', 'Airport assistance'],
                contact: HotelContact(
                  site: 'https://www.maansoor.com/',
                  phone: '+252 63 4422224',
                ),
                sources: ['https://www.maansoor.com/'],
              ),
              SomalilandHotel(
                name: 'Damal Hotel Hargeisa',
                whyFamous: 'Modern rooms; sister property of Damal Berbera.',
                amenities: ['Wi-Fi', 'Breakfast', 'Airport transfer (on request)'],
                contact: HotelContact(
                  site: 'https://www.damalhotels.com/',
                  phone: '+252 63 4455666',
                ),
                sources: ['https://www.damalhotels.com/'],
              ),
            ],
          ),

          // Berbera
          SomalilandCity(
            name: 'Berbera',
            region: 'Sahil',
            bio: 'Historic port on the Gulf of Aden; former capital of British Somaliland; gateway to beaches, reefs and diving.',
            details: CityDetails(
              population: 250000,
              timezone: 'UTC+3',
              language: 'Somali',
              currency: 'SLSH & USD',
              languages: ['Somali', 'Arabic', 'English'],
              bestTimeToVisit: 'November to March',
              localCuisine: 'Fresh seafood, rice, camel meat, tropical fruits',
              culturalNotes: 'Coastal culture, fishing traditions, more relaxed atmosphere',
            ),
            attractions: [
              'Berbera Beach',
              'Historic Port',
              'British Colonial Buildings',
              'Fish Market',
              'Coral Reefs',
              'Coastal Mountains',
              'Ancient Trade Routes',
              'Maritime Museum',
            ],
            activities: [
              'Beach swimming and sunbathing',
              'Snorkeling and diving',
              'Fishing trips',
              'Historical tours',
              'Beach sports',
              'Photography',
              'Local market visits',
              'Coastal hiking',
            ],
            climate: ClimateInfo(
              climateType: 'Hot desert',
              averageTemperature: 30.0,
              rainySeason: 'April to June',
              drySeason: 'July to March',
              bestTimeToVisit: 'November to March (cooler)',
              weatherNotes: [
                'Very hot and humid year-round',
                'Coastal breezes provide relief',
                'High humidity levels',
                'Minimal rainfall',
              ],
            ),
            transportation: TransportationInfo(
              airportInfo: 'No airport, access via Hargeisa (3 hours by road)',
              busInfo: 'Regular buses from Hargeisa',
              taxiInfo: 'Local taxis available, negotiate prices',
              carRental: 'Limited availability, arrange in Hargeisa',
              localTransport: ['Buses', 'Taxis', 'Walking', 'Boat taxis'],
              roadConditions: 'Main road paved, coastal roads may be rough',
            ),
            safety: SafetyInfo(
              safetyLevel: 'Generally safe, exercise normal caution',
              safetyTips: [
                'Swim only in designated areas',
                'Protect against sun and heat',
                'Stay hydrated',
                'Respect local customs',
                'Keep valuables secure',
              ],
              healthNotes: [
                'High risk of sunburn',
                'Stay hydrated in hot climate',
                'Use sunscreen and protective clothing',
                'Be aware of heat exhaustion',
              ],
              emergencyNumbers: 'Police: 999, Ambulance: 999, Fire: 999',
              localCustoms: [
                'Dress appropriately for beach',
                'Respect fishing traditions',
                'Ask permission before photographing',
                'Support local businesses',
              ],
            ),
            topHotels: [
              SomalilandHotel(
                name: 'Damal Hotel Berbera',
                whyFamous: 'Modern option near the seafront; part of Damal brand.',
                amenities: ['Wi-Fi', 'Restaurant', 'Seafront access (area)'],
                contact: HotelContact(
                  site: 'https://www.damalhotels.com/',
                  note: 'Use website/phone to confirm current rates',
                ),
                sources: ['https://www.damalhotels.com/'],
              ),
              SomalilandHotel(
                name: 'Maansoor Hotel Berbera',
                whyFamous: 'Sister to Hargeisa\'s Maansoor; trusted choice in the port city.',
                amenities: ['Wi-Fi', 'Dining', 'Event spaces'],
                contact: HotelContact(
                  page: 'https://www.facebook.com/Mansoor-Hotel-Berbera-969200413150350/',
                ),
                sources: ['https://www.facebook.com/Mansoor-Hotel-Berbera-969200413150350/'],
              ),
              SomalilandHotel(
                name: 'Aly Khan Hotel Berbera',
                whyFamous: 'Well-known local hotel option in central Berbera.',
                amenities: ['Wi-Fi (typical)', 'On-site dining (typical)'],
                contact: HotelContact(
                  page: 'https://www.facebook.com/alykhanhotel/',
                ),
                sources: ['https://www.facebook.com/alykhanhotel/'],
              ),
            ],
          ),

          // Burco (Burao)
          SomalilandCity(
            name: 'Burco (Burao)',
            region: 'Togdheer',
            bio: 'Second-largest city; commercial center of the interior and site of Somaliland\'s 1991 declaration.',
            details: CityDetails(
              population: 350000,
              timezone: 'UTC+3',
              language: 'Somali',
              currency: 'SLSH & USD',
              languages: ['Somali', 'Arabic', 'English'],
              bestTimeToVisit: 'October to March',
              localCuisine: 'Traditional Somali dishes, camel meat, rice, vegetables',
              culturalNotes: 'Important historical city, center of independence movement',
            ),
            attractions: [
              'Independence Monument',
              'Central Market',
              'Historical Sites',
              'Local Museums',
              'Traditional Architecture',
              'Cultural Centers',
              'Public Squares',
              'Local Markets',
            ],
            activities: [
              'Historical tours',
              'Market exploration',
              'Cultural experiences',
              'Local cuisine tasting',
              'Photography',
              'Meeting locals',
              'Shopping for traditional items',
              'Learning about independence history',
            ],
            climate: ClimateInfo(
              climateType: 'Semi-arid',
              averageTemperature: 28.0,
              rainySeason: 'April to June',
              drySeason: 'July to March',
              bestTimeToVisit: 'October to March (cooler)',
              weatherNotes: [
                'Hot and dry climate',
                'Dust storms possible',
                'Strong winds common',
                'Limited rainfall',
              ],
            ),
            transportation: TransportationInfo(
              airportInfo: 'No airport, access via Hargeisa (2.5 hours by road)',
              busInfo: 'Regular buses from Hargeisa and other cities',
              taxiInfo: 'Local taxis available throughout the city',
              carRental: 'Limited availability, arrange in Hargeisa',
              localTransport: ['Buses', 'Taxis', 'Walking', 'Shared taxis'],
              roadConditions: 'Main roads paved, some side streets rough',
            ),
            safety: SafetyInfo(
              safetyLevel: 'Generally safe, normal precautions',
              safetyTips: [
                'Respect local customs',
                'Dress modestly',
                'Avoid political discussions',
                'Keep valuables secure',
                'Use registered transport',
              ],
              healthNotes: [
                'Bring basic medical supplies',
                'Drink bottled water',
                'Protect against dust',
                'Consider travel insurance',
              ],
              emergencyNumbers: 'Police: 999, Ambulance: 999, Fire: 999',
              localCustoms: [
                'Greet with traditional Somali greetings',
                'Respect prayer times',
                'Ask permission before photographing',
                'Support local businesses',
              ],
            ),
            topHotels: [
              SomalilandHotel(
                name: 'City Plaza Hotel (Burco)',
                whyFamous: 'One of the best-known modern properties in the city center.',
                amenities: ['Wi-Fi', 'Restaurant', 'Meeting space (typical)'],
                contact: HotelContact(
                  instaTag: '@cityplazahotelburco',
                  note: 'Active on Instagram',
                ),
                sources: ['https://www.instagram.com/p/CNu_SyAhoBY/'],
              ),
              SomalilandHotel(
                name: 'Kaah Hotel Burco',
                whyFamous: 'Longstanding local hotel with restaurant; frequently referenced by residents/visitors.',
                amenities: ['On-site dining', 'Wi-Fi (typical)'],
                contact: HotelContact(
                  instagramLocation: 'https://www.instagram.com/explore/locations/1998653940435646/kaah-hotel-burao/',
                ),
                sources: ['https://www.instagram.com/explore/locations/1998653940435646/kaah-hotel-burao/'],
              ),
              SomalilandHotel(
                name: 'Nugal Hotel Apartments (Burco)',
                whyFamous: 'Apartment-style stays; known locally for longer visits.',
                amenities: ['Apartment units', 'Wi-Fi (typical)'],
                contact: HotelContact(
                  page: 'https://www.facebook.com/NugalHotelApartments/',
                ),
                sources: ['https://www.facebook.com/NugalHotelApartments/'],
              ),
            ],
          ),

          // Gabiley
          SomalilandCity(
            name: 'Gabiley',
            region: 'Maroodi Jeex',
            alsoKnownAs: ['Gebiley'],
            bio: 'Agricultural heartland west of Hargeisa; smaller, low-rise town with a growing services sector.',
            details: CityDetails(
              population: 150000,
              timezone: 'UTC+3',
              language: 'Somali',
              currency: 'SLSH & USD',
              languages: ['Somali', 'Arabic', 'English'],
              bestTimeToVisit: 'October to March',
              localCuisine: 'Fresh agricultural produce, traditional Somali dishes',
              culturalNotes: 'Agricultural community, traditional farming practices',
            ),
            attractions: [
              'Agricultural Fields',
              'Local Markets',
              'Traditional Farms',
              'Community Centers',
              'Local Mosques',
              'Rural Landscapes',
              'Traditional Architecture',
              'Local Gardens',
            ],
            activities: [
              'Agricultural tours',
              'Market visits',
              'Local farm experiences',
              'Photography of rural life',
              'Traditional craft learning',
              'Local cuisine tasting',
              'Community interactions',
              'Nature walks',
            ],
            climate: ClimateInfo(
              climateType: 'Semi-arid',
              averageTemperature: 26.0,
              rainySeason: 'April to June',
              drySeason: 'July to March',
              bestTimeToVisit: 'October to March (cooler)',
              weatherNotes: [
                'Moderate temperatures',
                'Agricultural climate',
                'Some rainfall during season',
                'Good for farming',
              ],
            ),
            transportation: TransportationInfo(
              airportInfo: 'No airport, access via Hargeisa (1 hour by road)',
              busInfo: 'Regular buses from Hargeisa',
              taxiInfo: 'Local taxis available',
              carRental: 'Limited availability, arrange in Hargeisa',
              localTransport: ['Buses', 'Taxis', 'Walking', 'Shared transport'],
              roadConditions: 'Main road paved, rural roads may be rough',
            ),
            safety: SafetyInfo(
              safetyLevel: 'Very safe, rural community',
              safetyTips: [
                'Respect farming activities',
                'Ask permission before entering farms',
                'Dress appropriately',
                'Support local agriculture',
                'Be mindful of livestock',
              ],
              healthNotes: [
                'Bring basic medical supplies',
                'Drink bottled water',
                'Protect against sun',
                'Consider travel insurance',
              ],
              emergencyNumbers: 'Police: 999, Ambulance: 999, Fire: 999',
              localCustoms: [
                'Respect farming traditions',
                'Greet farmers respectfully',
                'Ask before photographing',
                'Support local produce',
              ],
            ),
            topHotels: [
              SomalilandHotel(
                name: 'Maamuus Hotel Gabiley',
                whyFamous: 'Best-known local hotel; used for community events.',
                amenities: ['Dining', 'Event space (typical)'],
                contact: HotelContact(
                  page: 'https://web.facebook.com/maamuus.hotel.gabiley/',
                ),
                sources: ['https://web.facebook.com/maamuus.hotel.gabiley/'],
              ),
              SomalilandHotel(
                name: 'RIO Hotel Gabiley',
                whyFamous: 'Centrally located guest hotel.',
                amenities: ['Basic rooms', 'Wi-Fi (typical)'],
                contact: HotelContact(
                  maps: 'https://maps.app.goo.gl/k1w8VGvHnLiJ9R2E6',
                ),
                sources: ['https://www.google.com/maps/place/RIO+Hotel'],
              ),
              SomalilandHotel(
                name: 'Gabiley Guest Houses (various)',
                whyFamous: 'Several small guesthouses operate with offline booking; confirm locally.',
                amenities: ['Basic rooms'],
                contact: HotelContact(
                  note: 'Ask locally or via taxi drivers for current options.',
                ),
                sources: ['https://www.trip.com/hotels/gabiley-hotels-list-78836/'],
              ),
            ],
          ),

          // Ceerigaabo (Erigavo)
          SomalilandCity(
            name: 'Ceerigaabo (Erigavo)',
            region: 'Sanaag',
            bio: 'Green highland capital of Sanaag near Daallo Mountain; cooler climate; hub for hikes and scenic drives.',
            details: CityDetails(
              population: 200000,
              timezone: 'UTC+3',
              language: 'Somali',
              currency: 'SLSH & USD',
              languages: ['Somali', 'Arabic', 'English'],
              bestTimeToVisit: 'October to March',
              localCuisine: 'Highland cuisine, fresh vegetables, traditional dishes',
              culturalNotes: 'Highland culture, traditional mountain communities',
            ),
            attractions: [
              'Daallo Mountain',
              'Highland Landscapes',
              'Traditional Villages',
              'Mountain Trails',
              'Local Markets',
              'Cultural Centers',
              'Scenic Viewpoints',
              'Traditional Architecture',
            ],
            activities: [
              'Mountain hiking',
              'Scenic drives',
              'Photography tours',
              'Cultural experiences',
              'Nature walks',
              'Local market visits',
              'Traditional craft learning',
              'Mountain climbing',
            ],
            climate: ClimateInfo(
              climateType: 'Highland semi-arid',
              averageTemperature: 22.0,
              rainySeason: 'April to June',
              drySeason: 'July to March',
              bestTimeToVisit: 'October to March (cooler)',
              weatherNotes: [
                'Cooler due to elevation',
                'Mountain climate',
                'Some rainfall during season',
                'Pleasant temperatures',
              ],
            ),
            transportation: TransportationInfo(
              airportInfo: 'No airport, access via Hargeisa (4 hours by road)',
              busInfo: 'Regular buses from Hargeisa',
              taxiInfo: 'Local taxis available',
              carRental: 'Limited availability, arrange in Hargeisa',
              localTransport: ['Buses', 'Taxis', 'Walking', 'Shared transport'],
              roadConditions: 'Main road paved, mountain roads may be rough',
            ),
            safety: SafetyInfo(
              safetyLevel: 'Generally safe, mountain environment',
              safetyTips: [
                'Stay on marked trails',
                'Bring appropriate gear',
                'Respect mountain environment',
                'Check weather conditions',
                'Inform locals of plans',
              ],
              healthNotes: [
                'Acclimatize to altitude',
                'Bring warm clothing',
                'Stay hydrated',
                'Consider travel insurance',
              ],
              emergencyNumbers: 'Police: 999, Ambulance: 999, Fire: 999',
              localCustoms: [
                'Respect mountain traditions',
                'Ask permission for activities',
                'Support local guides',
                'Leave no trace',
              ],
            ),
            topHotels: [
              SomalilandHotel(
                name: 'Andalus Hotel & Cafeteria',
                whyFamous: 'Central, well-known hotel; recently refurbished dining area.',
                amenities: ['Cafeteria/restaurant', 'Event space (often used)'],
                contact: HotelContact(
                  page: 'https://www.facebook.com/andalus.hotel.erigavo/',
                ),
                sources: ['https://www.facebook.com/andalus.hotel.erigavo/'],
              ),
              SomalilandHotel(
                name: 'Ugbaad Hotel (Erigavo)',
                whyFamous: 'Local favorite frequently recommended by residents for overnight stays.',
                amenities: ['Basic rooms', 'On-site dining (typical)'],
                contact: HotelContact(
                  instagramLocation: 'https://www.instagram.com/explore/locations/273689472755770/ugbaad-hotel/recent/',
                ),
                sources: ['https://www.instagram.com/explore/locations/273689472755770/ugbaad-hotel/recent/'],
              ),
              SomalilandHotel(
                name: 'Sanaag Hotel (legacy listing)',
                whyFamous: 'Older name that still circulates in local forums; verify current operation.',
                amenities: ['Basic rooms (unverified)'],
                contact: HotelContact(
                  note: 'Confirm locally by phone/in person.',
                ),
                sources: ['https://somalinet.com/forums/viewtopic.php?t=349014'],
              ),
            ],
          ),

          // Borama
          SomalilandCity(
            name: 'Borama',
            region: 'Awdal',
            bio: 'Leafy university town near the Ethiopian border; known for Amoud University and relaxed vibe.',
            details: CityDetails(
              population: 180000,
              timezone: 'UTC+3',
              language: 'Somali',
              currency: 'SLSH & USD',
              languages: ['Somali', 'Arabic', 'English'],
              bestTimeToVisit: 'October to March',
              localCuisine: 'University town cuisine, traditional Somali dishes, international options',
              culturalNotes: 'Academic atmosphere, university town culture, near Ethiopian border',
            ),
            attractions: [
              'Amoud University',
              'University Campus',
              'Local Markets',
              'Cultural Centers',
              'Traditional Architecture',
              'Border Area Views',
              'Local Gardens',
              'Community Centers',
            ],
            activities: [
              'University campus tours',
              'Cultural experiences',
              'Local market visits',
              'Photography',
              'Meeting students',
              'Traditional craft learning',
              'Local cuisine tasting',
              'Border area exploration',
            ],
            climate: ClimateInfo(
              climateType: 'Semi-arid',
              averageTemperature: 24.0,
              rainySeason: 'April to June',
              drySeason: 'July to March',
              bestTimeToVisit: 'October to March (cooler)',
              weatherNotes: [
                'Moderate temperatures',
                'University town climate',
                'Some rainfall during season',
                'Pleasant for students',
              ],
            ),
            transportation: TransportationInfo(
              airportInfo: 'No airport, access via Hargeisa (3 hours by road)',
              busInfo: 'Regular buses from Hargeisa and Ethiopia',
              taxiInfo: 'Local taxis available throughout the city',
              carRental: 'Limited availability, arrange in Hargeisa',
              localTransport: ['Buses', 'Taxis', 'Walking', 'Shared transport'],
              roadConditions: 'Main roads paved, some side streets rough',
            ),
            safety: SafetyInfo(
              safetyLevel: 'Very safe, university town',
              safetyTips: [
                'Respect university environment',
                'Dress appropriately',
                'Support local students',
                'Respect local customs',
                'Keep valuables secure',
              ],
              healthNotes: [
                'Bring basic medical supplies',
                'Drink bottled water',
                'Protect against sun',
                'Consider travel insurance',
              ],
              emergencyNumbers: 'Police: 999, Ambulance: 999, Fire: 999',
              localCustoms: [
                'Respect academic environment',
                'Greet students respectfully',
                'Support local education',
                'Ask permission before photographing',
              ],
            ),
            topHotels: [
              SomalilandHotel(
                name: 'Rays Hotel (Borama)',
                whyFamous: 'Long-established and active hotel in town center.',
                amenities: ['Wi-Fi', 'Restaurant', 'Event hosting (frequent)'],
                contact: HotelContact(
                  instaTag: 'https://www.instagram.com/p/CJvPVADAlZV/',
                  page: 'https://www.facebook.com/100064347955697/videos/rays-hotel/559566654729706/',
                ),
                sources: [
                  'https://www.instagram.com/p/CJvPVADAlZV/',
                  'https://www.facebook.com/100064347955697/videos/rays-hotel/559566654729706/',
                ],
              ),
              SomalilandHotel(
                name: 'Haldoor Hotel (Borama)',
                whyFamous: 'Renovated/relaunched recently; popular for events and dining.',
                amenities: ['Wi-Fi (typical)', 'Restaurant', 'Event space'],
                contact: HotelContact(
                  page: 'https://www.facebook.com/Suxufi01/videos/new-haldoor-hotel-oo-si-casriya-loo-habeeyay-ayaa-laga-daahfuray-magalada-borama/963819215085173/',
                ),
                sources: ['https://www.facebook.com/Suxufi01/videos/new-haldoor-hotel-oo-si-casriya-loo-habeeyay-ayaa-laga-daahfuray-magalada-borama/963819215085173/'],
              ),
              SomalilandHotel(
                name: 'Safari Hotel & Resort (Borama)',
                whyFamous: 'Resort-style complex often used for local celebrations.',
                amenities: ['Spacious grounds', 'Restaurant', 'Event venues'],
                contact: HotelContact(
                  page: 'https://www.facebook.com/SadamCaqli/videos/hotel-safari-borama-somaliland/1254460055878252/',
                ),
                sources: ['https://www.facebook.com/SadamCaqli/videos/hotel-safari-borama-somaliland/1254460055878252/'],
              ),
            ],
          ),
        ],
        practicalities: TravelPracticalities(
          gettingIn: GettingIn(
            airports: [
              Airport(
                name: 'Egal International Airport (HGA), Hargeisa',
                notes: 'Main gateway; long 3,700 m runway; public airport; renovated 2012–13.',
                sources: [
                  'https://en.wikipedia.org/wiki/Hargeisa_Airport',
                  'https://mocaad.govsomaliland.org/article/egal-international-airport',
                ],
              ),
            ],
            visa: VisaInfo(
              summary: 'Somaliland has its own visa policy. Many nationalities can obtain Visa on Arrival (VoA); always check official guidance before travel.',
              helpfulLinks: [
                'https://www.slimmigration.com/visa-section/',
                'https://mfa.govsomaliland.org/article/visa-consular-services-1',
                'https://againstthecompass.com/en/travel-somaliland/',
              ],
              caution: 'Most countries\' Somalia advisories cover Somaliland; assess risk and check latest advisories.',
            ),
          ),
          money: Money(
            currency: 'Somaliland Shilling (SLSH) is used locally; USD is widely accepted.',
            tip: 'Rates vary; cash is king. Mobile money (e.g., ZAAD) is common.',
            sources: ['https://visithornafrica.com/somaliland-currency/'],
          ),
          connectivity: Connectivity(
            summary: '4G in major towns; SIMs available in Hargeisa (bring passport). Mobile money widely used.',
          ),
          whenToGo: WhenToGo(
            summary: 'Generally dry most of the year; coastal Berbera is hottest and humid; Hargeisa is milder due to altitude.',
            sources: [
              'https://en.wikipedia.org/wiki/Hargeisa',
              'https://en.wikipedia.org/wiki/Berbera',
            ],
          ),
        ),
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load guide data: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get city by name
  SomalilandCity? getCityByName(String cityName) {
    if (_guide == null) return null;
    try {
      return _guide!.cities.firstWhere(
        (city) => city.name.toLowerCase().contains(cityName.toLowerCase()) ||
                  city.alsoKnownAs.any((alias) => alias.toLowerCase().contains(cityName.toLowerCase())),
      );
    } catch (e) {
      return null;
    }
  }

  // Get cities by region
  List<SomalilandCity> getCitiesByRegion(String region) {
    if (_guide == null) return [];
    return _guide!.cities.where((city) => city.region == region).toList();
  }

  // Get all regions
  List<String> getAllRegions() {
    if (_guide == null) return [];
    return _guide!.cities.map((city) => city.region).toSet().toList();
  }

  // Search hotels by amenity
  List<SomalilandHotel> searchHotelsByAmenity(String amenity) {
    if (_guide == null) return [];
    List<SomalilandHotel> results = [];
    for (var city in _guide!.cities) {
      for (var hotel in city.topHotels) {
        if (hotel.amenities.any((a) => a.toLowerCase().contains(amenity.toLowerCase()))) {
          results.add(hotel);
        }
      }
    }
    return results;
  }

  // Get hotels by price range
  List<SomalilandHotel> getHotelsByPriceRange(double minPrice, double maxPrice) {
    if (_guide == null) return [];
    List<SomalilandHotel> results = [];
    for (var city in _guide!.cities) {
      for (var hotel in city.topHotels) {
        // Mock price calculation for demonstration
        final hotelPrice = _getMockHotelPrice(hotel.name);
        if (hotelPrice >= minPrice && hotelPrice <= maxPrice) {
          results.add(hotel);
        }
      }
    }
    return results;
  }

  // Get hotels by category (budget, mid-range, luxury)
  List<SomalilandHotel> getHotelsByCategory(String category) {
    if (_guide == null) return [];
    List<SomalilandHotel> results = [];
    for (var city in _guide!.cities) {
      for (var hotel in city.topHotels) {
        final hotelCategory = _getHotelCategory(hotel.name);
        if (hotelCategory.toLowerCase() == category.toLowerCase()) {
          results.add(hotel);
        }
      }
    }
    return results;
  }

  // Mock price calculation for demonstration
  double _getMockHotelPrice(String hotelName) {
    if (hotelName.toLowerCase().contains('ambassador') || 
        hotelName.toLowerCase().contains('damal')) {
      return 80.0; // Luxury
    } else if (hotelName.toLowerCase().contains('maansoor') || 
               hotelName.toLowerCase().contains('city plaza')) {
      return 50.0; // Mid-range
    } else {
      return 25.0; // Budget
    }
  }

  // Mock category assignment for demonstration
  String _getHotelCategory(String hotelName) {
    if (hotelName.toLowerCase().contains('ambassador') || 
        hotelName.toLowerCase().contains('damal')) {
      return 'Luxury';
    } else if (hotelName.toLowerCase().contains('maansoor') || 
               hotelName.toLowerCase().contains('city plaza')) {
      return 'Mid-range';
    } else {
      return 'Budget';
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
