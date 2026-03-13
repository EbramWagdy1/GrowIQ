import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/plant_types.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';

class PlantsInfoView extends StatefulWidget {
  const PlantsInfoView({super.key});

  @override
  State<PlantsInfoView> createState() => _PlantsInfoViewState();
}

class _PlantsInfoViewState extends State<PlantsInfoView> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allPlants = PlantConfig.defaultThresholds.keys.toList();
    final displayedPlants = allPlants.where((plant) {
      return plant.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: CustomAppBar(title: 'Plants Information'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search plants...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              itemCount: displayedPlants.length,
              itemBuilder: (context, index) {
                final plantName = displayedPlants[index];
          final thresholds = PlantConfig.defaultThresholds[plantName]!;

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 2,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.lightMint,
                  child: Icon(Icons.local_florist, color: AppColors.primaryColor),
                ),
                title: Text(
                  plantName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor2D,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        _buildThresholdRow(
                          icon: Icons.thermostat,
                          label: 'Air Temperature',
                          min: thresholds['air temperature']?['min'],
                          max: thresholds['air temperature']?['max'],
                          unit: '°C',
                          color: Colors.orange,
                        ),
                        _buildThresholdRow(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          min: thresholds['humidity']?['min'],
                          max: thresholds['humidity']?['max'],
                          unit: '%',
                          color: Colors.blue,
                        ),
                        _buildThresholdRow(
                          icon: Icons.grass,
                          label: 'Soil Moisture',
                          min: thresholds['soil moisture']?['min'],
                          max: thresholds['soil moisture']?['max'],
                          unit: '%',
                          color: Colors.brown,
                        ),
                        _buildThresholdRow(
                          icon: Icons.thermostat_auto,
                          label: 'Soil Temperature',
                          min: thresholds['soil temperature']?['min'],
                          max: thresholds['soil temperature']?['max'],
                          unit: '°C',
                          color: Colors.deepOrange,
                        ),
                        _buildThresholdRow(
                          icon: Icons.wb_sunny,
                          label: 'Light Level',
                          min: thresholds['light level']?['min'],
                          max: thresholds['light level']?['max'],
                          unit: ' lux',
                          color: Colors.amber,
                        ),
                        _buildThresholdRow(
                          icon: Icons.air,
                          label: 'Air Quality (CO2)',
                          min: thresholds['air quality']?['min'],
                          max: thresholds['air quality']?['max'],
                          unit: ' ppm',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  ],
),
    );
  }

  Widget _buildThresholdRow({
    required IconData icon,
    required String label,
    required double? min,
    required double? max,
    required String unit,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor2D,
              ),
            ),
          ),
          Text(
            '${min?.toStringAsFixed(0)} - ${max?.toStringAsFixed(0)}$unit',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
