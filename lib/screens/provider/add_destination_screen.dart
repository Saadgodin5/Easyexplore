import 'package:flutter/material.dart';
import '../../models/destination_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddDestinationScreen extends StatefulWidget {
  const AddDestinationScreen({super.key});

  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  
  String _selectedCategory = 'Culture';
  String _selectedCity = 'Hargeisa';
  double _latitude = 9.5616;
  double _longitude = 44.0670;
  
  final List<String> _categories = [
    'Culture',
    'Adventure',
    'Nature',
    'History',
    'Relaxation',
    'Food',
    'Shopping',
    'Other',
  ];
  
  final List<String> _cities = [
    'Hargeisa',
    'Berbera',
    'Borama',
    'Burco',
    'Gabiley',
    'Cerigabo',
  ];
  
  final Map<String, bool> _amenities = {
    'Guided Tour': false,
    'Transportation': false,
    'Refreshments': false,
    'Photography': false,
    'Equipment': false,
    'Safety Gear': false,
    'Lunch': false,
    'WiFi': false,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Destination'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information
              _buildSectionTitle('Basic Information'),
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _nameController,
                labelText: 'Destination Name',
                hintText: 'Enter destination name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination name';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _descriptionController,
                labelText: 'Description',
                hintText: 'Describe your destination',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  if (value.length < 20) {
                    return 'Description must be at least 20 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Category and Location
              _buildSectionTitle('Category & Location'),
              const SizedBox(height: 16),
              
              // Category dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) => 
                  DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // City dropdown
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                items: _cities.map((city) => 
                  DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  ),
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                    _updateCoordinates(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Pricing
              _buildSectionTitle('Pricing'),
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _priceController,
                labelText: 'Price (USD)',
                hintText: 'Enter price in USD',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.attach_money,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Price must be greater than 0';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Amenities
              _buildSectionTitle('Amenities'),
              const SizedBox(height: 16),
              
              _buildAmenitiesGrid(),
              
              const SizedBox(height: 32),
              
              // Submit button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: _submitForm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_location),
                      const SizedBox(width: 8),
                      const Text('Add Destination'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAmenitiesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemCount: _amenities.length,
      itemBuilder: (context, index) {
        final amenity = _amenities.keys.elementAt(index);
        final isSelected = _amenities[amenity]!;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _amenities[amenity] = !isSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected 
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected 
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      _amenities[amenity] = value!;
                    });
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Text(
                    amenity,
                    style: TextStyle(
                      color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateCoordinates(String city) {
    switch (city) {
      case 'Hargeisa':
        _latitude = 9.5616;
        _longitude = 44.0670;
        break;
      case 'Berbera':
        _latitude = 10.4340;
        _longitude = 45.0143;
        break;
      case 'Borama':
        _latitude = 9.9340;
        _longitude = 43.1860;
        break;
      case 'Burco':
        _latitude = 9.5221;
        _longitude = 45.5336;
        break;
      case 'Gabiley':
        _latitude = 9.7167;
        _longitude = 44.0667;
        break;
      case 'Cerigabo':
        _latitude = 11.3667;
        _longitude = 49.0167;
        break;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create destination object
      final destination = Destination(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        category: _selectedCategory,
        rating: 0.0,
        reviewCount: 0,
        images: [
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
        ],
        location: Location(
          latitude: _latitude,
          longitude: _longitude,
          address: '$_selectedCity City Center',
          city: _selectedCity,
          country: 'Somaliland',
        ),
        amenities: Map.fromEntries(
          _amenities.entries.where((entry) => entry.value)
        ),
        isVerified: false,
        providerId: 'provider1',
        price: double.parse(_priceController.text),
        currency: 'USD',
      );
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Destination "${destination.name}" added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate back
      Navigator.pop(context, destination);
    }
  }
}
