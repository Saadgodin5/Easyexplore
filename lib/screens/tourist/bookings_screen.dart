import 'package:flutter/material.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Show booking history
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBookingCard(
            context,
            'Eiffel Tower Tour',
            'Paris, France',
            'March 15, 2024',
            'Confirmed',
            Colors.green,
            Icons.location_on,
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            context,
            'Louvre Museum Entry',
            'Paris, France',
            'March 16, 2024',
            'Confirmed',
            Colors.green,
            Icons.museum,
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            context,
            'Seine River Cruise',
            'Paris, France',
            'March 15, 2024',
            'Pending',
            Colors.orange,
            Icons.directions_boat,
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            context,
            'Versailles Palace Tour',
            'Versailles, France',
            'March 17, 2024',
            'Confirmed',
            Colors.green,
            Icons.castle,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(
    BuildContext context,
    String title,
    String location,
    String date,
    String status,
    Color statusColor,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: View booking details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Viewing details for $title'),
                      ),
                    );
                  },
                  child: const Text('View Details'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Cancel booking
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cancelling $title'),
                      ),
                    );
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
