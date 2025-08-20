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

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      destinationName: json['destinationName'],
      customerName: json['customerName'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destinationName': destinationName,
      'customerName': customerName,
      'date': date.toIso8601String(),
      'status': status,
      'price': price,
      'currency': currency,
    };
  }

  Booking copyWith({
    String? id,
    String? destinationName,
    String? customerName,
    DateTime? date,
    String? status,
    double? price,
    String? currency,
  }) {
    return Booking(
      id: id ?? this.id,
      destinationName: destinationName ?? this.destinationName,
      customerName: customerName ?? this.customerName,
      date: date ?? this.date,
      status: status ?? this.status,
      price: price ?? this.price,
      currency: currency ?? this.currency,
    );
  }
}
