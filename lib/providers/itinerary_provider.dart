import 'package:flutter/material.dart';

class ItineraryItem {
  final String id;
  final String title;
  final String location;
  final DateTime date;
  final String time;
  final String notes;
  final bool isCompleted;

  ItineraryItem({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    this.notes = '',
    this.isCompleted = false,
  });

  ItineraryItem copyWith({
    String? id,
    String? title,
    String? location,
    DateTime? date,
    String? time,
    String? notes,
    bool? isCompleted,
  }) {
    return ItineraryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class ItineraryDay {
  final String id;
  final DateTime date;
  final List<ItineraryItem> items;

  ItineraryDay({
    required this.id,
    required this.date,
    required this.items,
  });
}

class ItineraryProvider extends ChangeNotifier {
  List<ItineraryDay> _itinerary = [];
  bool _isLoading = false;
  String? _error;

  List<ItineraryDay> get itinerary => _itinerary;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Mock data for MVP
  void loadMockItinerary() {
    _itinerary = [
      ItineraryDay(
        id: '1',
        date: DateTime.now().add(const Duration(days: 1)),
        items: [
          ItineraryItem(
            id: '1',
            title: 'Eiffel Tower',
            location: 'Champ de Mars, Paris',
            date: DateTime.now().add(const Duration(days: 1)),
            time: '9:00 AM',
            notes: 'Book tickets in advance',
          ),
          ItineraryItem(
            id: '2',
            title: 'Louvre Museum',
            location: 'Rue de Rivoli, Paris',
            date: DateTime.now().add(const Duration(days: 1)),
            time: '2:00 PM',
            notes: 'Skip the line tickets available',
          ),
          ItineraryItem(
            id: '3',
            title: 'Seine River Cruise',
            location: 'Port de la Bourdonnais, Paris',
            date: DateTime.now().add(const Duration(days: 1)),
            time: '7:00 PM',
            notes: 'Sunset cruise recommended',
          ),
        ],
      ),
      ItineraryDay(
        id: '2',
        date: DateTime.now().add(const Duration(days: 2)),
        items: [
          ItineraryItem(
            id: '4',
            title: 'Notre-Dame Cathedral',
            location: 'Île de la Cité, Paris',
            date: DateTime.now().add(const Duration(days: 2)),
            time: '10:00 AM',
            notes: 'Free entry, arrive early',
          ),
          ItineraryItem(
            id: '5',
            title: 'Arc de Triomphe',
            location: 'Place Charles de Gaulle, Paris',
            date: DateTime.now().add(const Duration(days: 2)),
            time: '3:00 PM',
            notes: 'Great views from the top',
          ),
          ItineraryItem(
            id: '6',
            title: 'Champs-Élysées Walk',
            location: 'Champs-Élysées, Paris',
            date: DateTime.now().add(const Duration(days: 2)),
            time: '6:00 PM',
            notes: 'Shopping and dining',
          ),
        ],
      ),
      ItineraryDay(
        id: '3',
        date: DateTime.now().add(const Duration(days: 3)),
        items: [
          ItineraryItem(
            id: '7',
            title: 'Palace of Versailles',
            location: 'Versailles, France',
            date: DateTime.now().add(const Duration(days: 3)),
            time: '9:00 AM',
            notes: 'Full day trip from Paris',
          ),
          ItineraryItem(
            id: '8',
            title: 'Gardens Tour',
            location: 'Versailles Gardens',
            date: DateTime.now().add(const Duration(days: 3)),
            time: '2:00 PM',
            notes: 'Beautiful fountains and sculptures',
          ),
        ],
      ),
    ];
    notifyListeners();
  }

  Future<void> addItineraryItem(String dayId, ItineraryItem item) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final dayIndex = _itinerary.indexWhere((day) => day.id == dayId);
      if (dayIndex != -1) {
        _itinerary[dayIndex].items.add(item);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to add item: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateItineraryItem(String dayId, String itemId, ItineraryItem updatedItem) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final dayIndex = _itinerary.indexWhere((day) => day.id == dayId);
      if (dayIndex != -1) {
        final itemIndex = _itinerary[dayIndex].items.indexWhere((item) => item.id == itemId);
        if (itemIndex != -1) {
          _itinerary[dayIndex].items[itemIndex] = updatedItem;
        }
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to update item: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeItineraryItem(String dayId, String itemId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      final dayIndex = _itinerary.indexWhere((day) => day.id == dayId);
      if (dayIndex != -1) {
        _itinerary[dayIndex].items.removeWhere((item) => item.id == itemId);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to remove item: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleItemCompletion(String dayId, String itemId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 300));
      
      final dayIndex = _itinerary.indexWhere((day) => day.id == dayId);
      if (dayIndex != -1) {
        final itemIndex = _itinerary[dayIndex].items.indexWhere((item) => item.id == itemId);
        if (itemIndex != -1) {
          final item = _itinerary[dayIndex].items[itemIndex];
          _itinerary[dayIndex].items[itemIndex] = item.copyWith(
            isCompleted: !item.isCompleted,
          );
        }
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to toggle completion: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
