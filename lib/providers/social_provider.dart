import 'package:flutter/material.dart';

class Review {
  final String id;
  final String userId;
  final String userName;
  final String destinationId;
  final String destinationName;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final List<String> images;
  final int likes;
  final List<String> likedBy;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.destinationId,
    required this.destinationName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.images = const [],
    this.likes = 0,
    this.likedBy = const [],
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      destinationId: json['destinationId'],
      destinationName: json['destinationName'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      images: List<String>.from(json['images'] ?? []),
      likes: json['likes'] ?? 0,
      likedBy: List<String>.from(json['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'destinationId': destinationId,
      'destinationName': destinationName,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'images': images,
      'likes': likes,
      'likedBy': likedBy,
    };
  }

  Review copyWith({
    String? id,
    String? userId,
    String? userName,
    String? destinationId,
    String? destinationName,
    double? rating,
    String? comment,
    DateTime? createdAt,
    List<String>? images,
    int? likes,
    List<String>? likedBy,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      destinationId: destinationId ?? this.destinationId,
      destinationName: destinationName ?? this.destinationName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      likes: likes ?? this.likes,
      likedBy: likedBy ?? this.likedBy,
    );
  }
}

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String reviewId;
  final String content;
  final DateTime createdAt;
  final int likes;
  final List<String> likedBy;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.reviewId,
    required this.content,
    required this.createdAt,
    this.likes = 0,
    this.likedBy = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      reviewId: json['reviewId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      likes: json['likes'] ?? 0,
      likedBy: List<String>.from(json['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'reviewId': reviewId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
      'likedBy': likedBy,
    };
  }
}

class SocialProvider extends ChangeNotifier {
  List<Review> _reviews = [];
  List<Comment> _comments = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Review> get reviews => _reviews;
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize with mock data
  void initialize() {
    _loadMockData();
  }

  void _loadMockData() {
    _reviews = [
      Review(
        id: 'r1',
        userId: 'u1',
        userName: 'Ahmed Hassan',
        destinationId: '1',
        destinationName: 'Hargeisa Cultural Tour',
        rating: 5.0,
        comment: 'Amazing experience! The guide was very knowledgeable and the cultural insights were incredible. Highly recommend!',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        images: [
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        ],
        likes: 12,
        likedBy: ['u2', 'u3', 'u4'],
      ),
      Review(
        id: 'r2',
        userId: 'u2',
        userName: 'Fatima Ali',
        destinationId: '2',
        destinationName: 'Berbera Beach Adventure',
        rating: 4.5,
        comment: 'Beautiful beach and great water activities. The staff was friendly and safety measures were excellent.',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        images: [
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        ],
        likes: 8,
        likedBy: ['u1', 'u3'],
      ),
      Review(
        id: 'r3',
        userId: 'u3',
        userName: 'Omar Mohamed',
        destinationId: '3',
        destinationName: 'Borama Mountain Trek',
        rating: 4.8,
        comment: 'Spectacular views and challenging trails. Perfect for adventure seekers. The mountain guide was professional.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        images: [
          'https://images.unsplash.com/photo-1551632811-561732d1e306?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        ],
        likes: 15,
        likedBy: ['u1', 'u2', 'u4', 'u5'],
      ),
    ];

    _comments = [
      Comment(
        id: 'c1',
        userId: 'u4',
        userName: 'Amina Yusuf',
        reviewId: 'r1',
        content: 'I agree! The cultural tour was fantastic. When did you go?',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likes: 3,
        likedBy: ['u1', 'u2'],
      ),
      Comment(
        id: 'c2',
        userId: 'u5',
        userName: 'Hassan Abdi',
        reviewId: 'r2',
        content: 'How was the water temperature? Planning to visit next month.',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        likes: 1,
        likedBy: ['u2'],
      ),
    ];

    notifyListeners();
  }

  // Add new review
  Future<bool> addReview(Review review) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _reviews.insert(0, review);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to add review: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Add comment to review
  Future<bool> addComment(Comment comment) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      _comments.add(comment);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to add comment: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Like/unlike review
  Future<bool> toggleReviewLike(String reviewId, String userId) async {
    try {
      final reviewIndex = _reviews.indexWhere((r) => r.id == reviewId);
      if (reviewIndex != -1) {
        final review = _reviews[reviewIndex];
        final isLiked = review.likedBy.contains(userId);
        
        if (isLiked) {
          // Unlike
          review.likedBy.remove(userId);
          _reviews[reviewIndex] = review.copyWith(
            likes: review.likes - 1,
            likedBy: review.likedBy,
          );
        } else {
          // Like
          review.likedBy.add(userId);
          _reviews[reviewIndex] = review.copyWith(
            likes: review.likes + 1,
            likedBy: review.likedBy,
          );
        }
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Failed to toggle like: $e';
      notifyListeners();
      return false;
    }
  }

  // Like/unlike comment
  Future<bool> toggleCommentLike(String commentId, String userId) async {
    try {
      final commentIndex = _comments.indexWhere((c) => c.id == commentId);
      if (commentIndex != -1) {
        final comment = _comments[commentIndex];
        final isLiked = comment.likedBy.contains(userId);
        
        if (isLiked) {
          // Unlike
          comment.likedBy.remove(userId);
          _comments[commentIndex] = Comment(
            id: comment.id,
            userId: comment.userId,
            userName: comment.userName,
            reviewId: comment.reviewId,
            content: comment.content,
            createdAt: comment.createdAt,
            likes: comment.likes - 1,
            likedBy: comment.likedBy,
          );
        } else {
          // Like
          comment.likedBy.add(userId);
          _comments[commentIndex] = Comment(
            id: comment.id,
            userId: comment.userId,
            userName: comment.userName,
            reviewId: comment.reviewId,
            content: comment.content,
            createdAt: comment.createdAt,
            likes: comment.likes + 1,
            likedBy: comment.likedBy,
          );
        }
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Failed to toggle like: $e';
      notifyListeners();
      return false;
    }
  }

  // Get reviews for a destination
  List<Review> getReviewsForDestination(String destinationId) {
    return _reviews.where((r) => r.destinationId == destinationId).toList();
  }

  // Get comments for a review
  List<Comment> getCommentsForReview(String reviewId) {
    return _comments.where((c) => c.reviewId == reviewId).toList();
  }

  // Get reviews by user
  List<Review> getReviewsByUser(String userId) {
    return _reviews.where((r) => r.userId == userId).toList();
  }

  // Get average rating for destination
  double getAverageRatingForDestination(String destinationId) {
    final destinationReviews = getReviewsForDestination(destinationId);
    if (destinationReviews.isEmpty) return 0.0;
    
    final totalRating = destinationReviews.fold(0.0, (sum, review) => sum + review.rating);
    return totalRating / destinationReviews.length;
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
