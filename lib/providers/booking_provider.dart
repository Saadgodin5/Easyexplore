import 'package:flutter/material.dart';

class Booking {
  final String id;
  final String destinationName;
  final String customerName;
  final DateTime date;
  final String status;
  final double price;
  final String currency;

  Booking({
    required this.id,
    required this.destinationName,
    required this.customerName,
    required this.date,
    required this.status,
    required this.price,
    required this.currency,
  });
}

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Mock data for MVP
  void loadMockBookings() {
    _bookings = [
      Booking(
        id: '1',
        destinationName: 'Eiffel Tower Tour',
        customerName: 'John Smith',
        date: DateTime.now().add(const Duration(days: 1)),
        status: 'Confirmed',
        price: 26.0,
        currency: 'EUR',
      ),
      Booking(
        id: '2',
        destinationName: 'Louvre Museum Entry',
        customerName: 'Sarah Johnson',
        date: DateTime.now().add(const Duration(days: 2)),
        status: 'Confirmed',
        price: 17.0,
        currency: 'EUR',
      ),
      Booking(
        id: '3',
        destinationName: 'Seine River Cruise',
        customerName: 'Mike Wilson',
        date: DateTime.now().add(const Duration(days: 1)),
        status: 'Pending',
        price: 35.0,
        currency: 'EUR',
      ),
    ];
    notifyListeners();
  }

  Future<void> createBooking(Booking booking) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _bookings.add(booking);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to create booking: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _bookings[index] = Booking(
          id: _bookings[index].id,
          destinationName: _bookings[index].destinationName,
          customerName: _bookings[index].customerName,
          date: _bookings[index].date,
          status: newStatus,
          price: _bookings[index].price,
          currency: _bookings[index].currency,
        );
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to update booking: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      _bookings.removeWhere((b) => b.id == bookingId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to cancel booking: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
