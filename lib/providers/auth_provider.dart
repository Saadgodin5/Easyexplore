import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  // Mock authentication for MVP
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock user data - replace with actual Firebase auth later
      if (email == 'saadgidin2@gmail.com' && password == 'Ibrahim09871') {
        _currentUser = User(
          id: '1',
          email: email,
          name: 'Saad Gidin',
          role: UserRole.tourist,
          createdAt: DateTime.now(),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else if (email == 'tourist@example.com' && password == 'password') {
        _currentUser = User(
          id: '2',
          email: email,
          name: 'John Tourist',
          role: UserRole.tourist,
          createdAt: DateTime.now(),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else if (email == 'provider@example.com' && password == 'password') {
        _currentUser = User(
          id: '3',
          email: email,
          name: 'Jane Provider',
          role: UserRole.provider,
          createdAt: DateTime.now(),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Authentication failed: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String name, UserRole role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Check if user already exists (for demo purposes)
      if (email == 'saadgidin2@gmail.com') {
        _error = 'Account already exists. Please sign in instead.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
      
      // Mock user creation - replace with actual Firebase auth later
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        role: role,
        createdAt: DateTime.now(),
      );
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Registration failed: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      _currentUser = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Sign out failed: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Exit guest mode and return to login screen
  Future<void> exitGuestMode() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      _currentUser = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to exit guest mode: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Guest mode - allows users to access the app without authentication
  Future<void> enterGuestMode() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Create a temporary guest user
      _currentUser = User(
        id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        email: 'guest@exploreease.com',
        name: 'Guest User',
        role: UserRole.tourist,
        createdAt: DateTime.now(),
        isGuest: true, // Mark as guest user
      );
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to enter guest mode: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Check if current user is a guest
  bool get isGuestUser => _currentUser?.isGuest ?? false;
}
