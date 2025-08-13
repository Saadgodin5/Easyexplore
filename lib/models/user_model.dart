enum UserRole { tourist, provider, admin }

class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final UserRole role;
  final DateTime createdAt;
  final bool isVerified;
  final Map<String, dynamic>? preferences;
  final bool isGuest;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    required this.role,
    required this.createdAt,
    this.isVerified = false,
    this.preferences,
    this.isGuest = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profileImage'],
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
        orElse: () => UserRole.tourist,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      isVerified: json['isVerified'] ?? false,
      preferences: json['preferences'],
      isGuest: json['isGuest'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'role': role.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
      'preferences': preferences,
      'isGuest': isGuest,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImage,
    UserRole? role,
    DateTime? createdAt,
    bool? isVerified,
    Map<String, dynamic>? preferences,
    bool? isGuest,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
      preferences: preferences ?? this.preferences,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}
