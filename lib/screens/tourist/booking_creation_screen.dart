import 'package:flutter/material.dart';
import '../../models/destination_model.dart';
import '../../models/booking_model.dart';
import 'payment_screen.dart';

class BookingCreationScreen extends StatefulWidget {
  final Destination destination;
  
  const BookingCreationScreen({
    super.key,
    required this.destination,
  });

  @override
  State<BookingCreationScreen> createState() => _BookingCreationScreenState();
}

class _BookingCreationScreenState extends State<BookingCreationScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  int _numberOfGuests = 1;
  String _selectedPackage = 'Standard';
  
  final List<String> _availablePackages = [
    'Standard',
    'Premium',
    'VIP',
  ];

  @override
  Widget build(BuildContext context) {
    final totalPrice = (widget.destination.price ?? 0) * _numberOfGuests;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Experience'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Summary Card
            _buildDestinationSummary(),
            
            const SizedBox(height: 24),
            
            // Date Selection
            _buildSectionTitle('Select Date'),
            const SizedBox(height: 12),
            _buildDateSelector(),
            
            const SizedBox(height: 24),
            
            // Time Selection
            _buildSectionTitle('Select Time'),
            const SizedBox(height: 12),
            _buildTimeSelector(),
            
            const SizedBox(height: 24),
            
            // Number of Guests
            _buildSectionTitle('Number of Guests'),
            const SizedBox(height: 12),
            _buildGuestSelector(),
            
            const SizedBox(height: 24),
            
            // Package Selection
            _buildSectionTitle('Select Package'),
            const SizedBox(height: 12),
            _buildPackageSelector(),
            
            const SizedBox(height: 24),
            
            // Price Breakdown
            _buildSectionTitle('Price Breakdown'),
            const SizedBox(height: 12),
            _buildPriceBreakdown(totalPrice),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
      
      // Bottom Button
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Total Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              
              // Continue to Payment Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _createBooking();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue to Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Destination Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Icon(Icons.image, color: Colors.grey[600]),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Destination Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.destination.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.destination.location.city}, ${widget.destination.location.country}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber[600]),
                    const SizedBox(width: 4),
                    Text(
                      widget.destination.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' (${widget.destination.reviewCount} reviews)',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now().add(const Duration(days: 1)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
            child: const Text('Change Date'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _selectedTime.format(context),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
              );
              if (picked != null) {
                setState(() {
                  _selectedTime = picked;
                });
              }
            },
            child: const Text('Change Time'),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.group, color: Colors.grey[600]),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Number of Guests',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_numberOfGuests > 1) {
                    setState(() {
                      _numberOfGuests--;
                    });
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _numberOfGuests > 1 ? Colors.grey[200] : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color: _numberOfGuests > 1 ? Colors.grey[700] : Colors.grey[400],
                  ),
                ),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$_numberOfGuests',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_numberOfGuests < 20) {
                    setState(() {
                      _numberOfGuests++;
                    });
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _numberOfGuests < 20 ? Colors.grey[200] : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: _numberOfGuests < 20 ? Colors.grey[700] : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackageSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: _availablePackages.map((package) {
          final isSelected = package == _selectedPackage;
          return RadioListTile<String>(
            value: package,
            groupValue: _selectedPackage,
            onChanged: (value) {
              setState(() {
                _selectedPackage = value!;
              });
            },
            title: Text(
              package,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              _getPackageDescription(package),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    );
  }

  String _getPackageDescription(String package) {
    switch (package) {
      case 'Standard':
        return 'Basic tour with guide and transportation';
      case 'Premium':
        return 'Includes meals and premium seating';
      case 'VIP':
        return 'Private guide, luxury transport, exclusive access';
      default:
        return '';
    }
  }

  Widget _buildPriceBreakdown(double totalPrice) {
    final basePrice = widget.destination.price ?? 0;
    final packageMultiplier = _getPackageMultiplier(_selectedPackage);
    final packagePrice = basePrice * packageMultiplier;
    final subtotal = packagePrice * _numberOfGuests;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          _buildPriceRow('Base Price', '\$${basePrice.toStringAsFixed(0)}'),
          _buildPriceRow('Package ($_selectedPackage)', '\$${(packagePrice - basePrice).toStringAsFixed(0)}'),
          _buildPriceRow('Guests × $_numberOfGuests', '\$${subtotal.toStringAsFixed(0)}'),
          const Divider(),
          _buildPriceRow('Total', '\$${totalPrice.toStringAsFixed(0)}', isTotal: true),
        ],
      ),
    );
  }

  double _getPackageMultiplier(String package) {
    switch (package) {
      case 'Standard':
        return 1.0;
      case 'Premium':
        return 1.5;
      case 'VIP':
        return 2.5;
      default:
        return 1.0;
    }
  }

  Widget _buildPriceRow(String label, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.grey[800] : Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            price,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Theme.of(context).colorScheme.primary : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  void _createBooking() {
    // Create a new booking
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      destinationName: widget.destination.name,
      customerName: 'Guest User', // TODO: Get from auth provider
      date: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      status: 'Pending',
      price: (widget.destination.price ?? 0) * _numberOfGuests,
      currency: 'USD',
    );

    // Add to booking provider
    // Navigate to payment screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          booking: booking,
          destination: widget.destination,
        ),
      ),
    );
  }
}
