import 'package:flutter/material.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Itinerary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add new activity
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add activity coming soon!')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDayCard(context, 'Day 1 - Paris', [
            'Eiffel Tower (9:00 AM)',
            'Louvre Museum (2:00 PM)',
            'Seine River Cruise (7:00 PM)',
          ]),
          const SizedBox(height: 16),
          _buildDayCard(context, 'Day 2 - Paris', [
            'Notre-Dame Cathedral (10:00 AM)',
            'Arc de Triomphe (3:00 PM)',
            'Champs-Élysées Walk (6:00 PM)',
          ]),
          const SizedBox(height: 16),
          _buildDayCard(context, 'Day 3 - Versailles', [
            'Palace of Versailles (9:00 AM)',
            'Gardens Tour (2:00 PM)',
            'Return to Paris (6:00 PM)',
          ]),
        ],
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, String dayTitle, List<String> activities) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...activities.map((activity) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(activity)),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () {
                      // TODO: Edit activity
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
