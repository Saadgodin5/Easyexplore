# ExploreEase - Your Smart Travel Companion

A cross-platform mobile & web app that helps tourists discover destinations, plan itineraries, and book services, while allowing local providers to publish and manage listings.

## 🚀 Features

### Tourist Features
- **Personalized Dashboard** - Welcome screen with quick actions
- **Interactive Map** - Discover places and attractions (Google Maps integration planned)
- **Smart Itinerary Planner** - Plan and organize your trip activities
- **Booking System** - Reserve tours and services
- **Offline Mode** - Access guides and maps without internet
- **Multilingual Support** - Multiple language support (planned)
- **Reviews & Ratings** - Rate and review destinations

### Provider Features
- **Business Dashboard** - Manage services and view analytics
- **Service Publishing** - Add and edit service listings
- **Analytics Tools** - Track performance and bookings
- **Verification System** - Get verified as a trusted provider

### Admin Features
- **Content Moderation** - Review and approve listings
- **User Management** - Manage tourists and providers
- **Analytics Dashboard** - Platform-wide insights

## 🏗️ Architecture

- **Frontend**: Flutter (mobile + web)
- **State Management**: Provider pattern
- **Backend**: Node.js/Express or Django REST API (planned)
- **Database**: PostgreSQL or MongoDB (planned)
- **APIs**: Google Maps, Stripe/PayPal, Firebase Auth, Translation API (planned)

## 📱 Screenshots

### Tourist Dashboard
- Welcome screen with personalized greeting
- Quick action cards for main features
- Recent activity tracking
- Easy navigation to all features

### Explore Map
- Interactive map view (placeholder for Google Maps)
- Destination listings with details
- Search and filter capabilities
- Booking integration

### Itinerary Planner
- Day-by-day trip organization
- Drag-and-drop reordering (planned)
- Activity details and notes
- Completion tracking

### Provider Dashboard
- Business overview and statistics
- Service management tools
- Recent bookings display
- Performance metrics

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd explore_ease
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For mobile
   flutter run
   
   # For web
   flutter run -d chrome
   
   # For specific device
   flutter devices
   flutter run -d <device-id>
   ```

## Assets

Place your custom graphics here:

- `assets/images/` – photos and UI images
- `assets/icons/` – bottom bar icons (24–32px PNG/SVG recommended)

`pubspec.yaml` is configured to include these folders.

### Demo Credentials

For testing the MVP, use these demo accounts:

- **Tourist Account**: `tourist@example.com` / `password`
- **Provider Account**: `provider@example.com` / `password`

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_model.dart      # User and role models
│   └── destination_model.dart # Destination and location models
├── providers/                # State management
│   ├── auth_provider.dart   # Authentication state
│   ├── booking_provider.dart # Booking management
│   └── itinerary_provider.dart # Itinerary management
├── screens/                  # UI screens
│   ├── splash_screen.dart   # App launch screen
│   ├── auth/                # Authentication screens
│   │   └── login_screen.dart
│   ├── tourist/             # Tourist-specific screens
│   │   ├── tourist_dashboard.dart
│   │   ├── explore_map_screen.dart
│   │   ├── itinerary_screen.dart
│   │   ├── bookings_screen.dart
│   │   └── profile_screen.dart
│   └── provider/            # Provider-specific screens
│       └── provider_dashboard.dart
├── widgets/                  # Reusable UI components
│   ├── custom_button.dart   # Custom button widget
│   └── custom_text_field.dart # Custom text field widget
└── utils/                    # Utilities and helpers
    └── app_theme.dart       # App theme configuration
```

## 🔧 Configuration

### Dependencies

The app uses several key packages:

- **google_maps_flutter**: For map integration
- **provider**: For state management
- **firebase_auth**: For authentication (planned)
- **http/dio**: For API calls
- **shared_preferences**: For local storage
- **flutter_slidable**: For interactive list items
- **drag_and_drop_lists**: For itinerary reordering

### Environment Setup

1. **Google Maps API Key** (when implementing maps)
2. **Firebase Configuration** (when implementing auth)
3. **Payment Gateway Keys** (when implementing payments)

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📦 Building

### Android APK
```bash
flutter build apk --release
```

### iOS IPA
```bash
flutter build ios --release
```

### Web Build
```bash
flutter build web --release
```

## 🚧 MVP Status

### ✅ Completed
- Basic app structure and navigation
- Authentication system (mock)
- Tourist dashboard with all screens
- Provider dashboard
- Itinerary management
- Booking system (mock)
- Custom UI components
- Theme system (light/dark)

### 🚧 In Progress
- Google Maps integration
- Real API connections
- Payment processing
- Offline functionality

### 📋 Planned
- Push notifications
- Multi-language support
- Advanced search and filters
- Social features
- Admin panel
- Analytics dashboard

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

## 🔮 Roadmap

### Phase 1: Core MVP ✅
- Basic app structure
- Authentication
- Tourist and provider dashboards
- Mock data and functionality

### Phase 2: Real Integration 🚧
- Google Maps API
- Firebase authentication
- Real backend API
- Payment processing

### Phase 3: Advanced Features 📋
- Offline mode
- Multi-language support
- Push notifications
- Advanced analytics

### Phase 4: Scale & Optimize 📋
- Performance optimization
- Advanced search
- Social features
- Admin panel

---

**ExploreEase** - Making travel planning effortless and enjoyable! 🌍✈️
