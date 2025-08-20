import 'package:flutter/material.dart';
import '../models/destination_model.dart';
import '../models/booking_model.dart';
import '../models/user_model.dart';

class ProviderManagementProvider extends ChangeNotifier {
  List<Destination> _myDestinations = [];
  List<Booking> _myBookings = [];
  User? _currentProvider;
  bool _isLoading = false;
  String? _error;
  
  // Analytics data
  Map<String, dynamic> _analytics = {};
  double _totalRevenue = 0.0;
  int _totalBookings = 0;
  double _averageRating = 0.0;

  // Getters
  List<Destination> get myDestinations => _myDestinations;
  List<Booking> get myBookings => _myBookings;
  User? get currentProvider => _currentProvider;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic> get analytics => _analytics;
  double get totalRevenue => _totalRevenue;
  int get totalBookings => _totalBookings;
  double get averageRating => _averageRating;

  // Initialize provider data
  void initializeProvider(User provider) {
    _currentProvider = provider;
    _loadMockData();
    _calculateAnalytics();
  }

  // Load mock data for MVP
  void _loadMockData() {
    _myDestinations = [
      Destination(
        id: 'p1',
        name: 'Hargeisa Cultural Experience',
        description: 'Immerse yourself in the rich culture of Hargeisa with guided tours.',
        category: 'Culture',
        rating: 4.8,
        reviewCount: 45,
        images: [
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
          'https://images.unsplash.com/photo-1526772662000-3f88f10405ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        ],
        location: Location(
          latitude: 9.5616,
          longitude: 44.0670,
          address: 'Hargeisa City Center',
          city: 'Hargeisa',
          country: 'Somaliland',
        ),
        amenities: {
          'Guided Tour': true,
          'Transportation': true,
          'Refreshments': true,
          'Photography': true,
        },
        isVerified: true,
        providerId: _currentProvider?.id,
        price: 35.0,
        currency: 'USD',
      ),
      Destination(
        id: 'p2',
        name: 'Berbera Beach Adventure',
        description: 'Explore the beautiful beaches and coastal activities in Berbera.',
        category: 'Adventure',
        rating: 4.6,
        reviewCount: 32,
        images: [
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        ],
        location: Location(
          latitude: 10.4340,
          longitude: 45.0143,
          address: 'Berbera Beach',
          city: 'Berbera',
          country: 'Somaliland',
        ),
        amenities: {
          'Beach Equipment': true,
          'Water Sports': true,
          'Lunch': true,
          'Safety Gear': true,
        },
        isVerified: true,
        providerId: _currentProvider?.id,
        price: 45.0,
        currency: 'USD',
      ),
    ];

    _myBookings = [
      Booking(
        id: 'b1',
        destinationName: 'Hargeisa Cultural Experience',
        customerName: 'Ahmed Hassan',
        date: DateTime.now().add(const Duration(days: 2)),
        status: 'Confirmed',
        price: 35.0,
        currency: 'USD',
      ),
      Booking(
        id: 'b2',
        destinationName: 'Berbera Beach Adventure',
        customerName: 'Fatima Ali',
        date: DateTime.now().add(const Duration(days: 5)),
        status: 'Pending',
        price: 45.0,
        currency: 'USD',
      ),
    ];

    notifyListeners();
  }

  // Calculate analytics
  void _calculateAnalytics() {
    _totalBookings = _myBookings.length;
    _totalRevenue = _myBookings.fold(0.0, (sum, booking) => sum + booking.price);
    _averageRating = _myDestinations.fold(0.0, (sum, dest) => sum + dest.rating) / _myDestinations.length;
    
    _analytics = {
      'totalDestinations': _myDestinations.length,
      'activeBookings': _myBookings.where((b) => b.status == 'Confirmed').length,
      'pendingBookings': _myBookings.where((b) => b.status == 'Pending').length,
      'monthlyRevenue': _totalRevenue * 0.3, // Mock monthly calculation
      'customerSatisfaction': _averageRating,
    };
    
    notifyListeners();
  }

  // Add new destination
  Future<bool> addDestination(Destination destination) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      final newDestination = Destination(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: destination.name,
        description: destination.description,
        category: destination.category,
        rating: 0.0,
        reviewCount: 0,
        images: destination.images,
        location: destination.location,
        amenities: destination.amenities,
        isVerified: false,
        providerId: _currentProvider?.id,
        price: destination.price,
        currency: destination.currency,
      );
      
      _myDestinations.add(newDestination);
      _isLoading = false;
      _calculateAnalytics();
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to add destination: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update destination
  Future<bool> updateDestination(String destinationId, Destination updatedDestination) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final index = _myDestinations.indexWhere((d) => d.id == destinationId);
      if (index != -1) {
        _myDestinations[index] = updatedDestination;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _error = 'Destination not found';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to update destination: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete destination
  Future<bool> deleteDestination(String destinationId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      _myDestinations.removeWhere((d) => d.id == destinationId);
      _isLoading = false;
      _calculateAnalytics();
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to delete destination: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update booking status
  Future<bool> updateBookingStatus(String bookingId, String newStatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final index = _myBookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _myBookings[index] = _myBookings[index].copyWith(status: newStatus);
        _isLoading = false;
        _calculateAnalytics();
        notifyListeners();
        return true;
      }
      
      _error = 'Booking not found';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to update booking: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get bookings by status
  List<Booking> getBookingsByStatus(String status) {
    return _myBookings.where((b) => b.status == status).toList();
  }

  // Get destinations by category
  List<Destination> getDestinationsByCategory(String category) {
    return _myDestinations.where((d) => d.category == category).toList();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
