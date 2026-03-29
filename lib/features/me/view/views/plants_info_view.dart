import 'package:flutter/material.dart';
import 'package:growiq/core/utils/plant_types.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

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

  String getLocalizedPlantName(BuildContext context, String plantKey) {
    switch (plantKey.toLowerCase()) {
      case 'tomato': return AppLocalizations.of(context)!.tomato;
      case 'mint': return AppLocalizations.of(context)!.mint;
      case 'lettuce': return AppLocalizations.of(context)!.lettuce;
      case 'basil': return AppLocalizations.of(context)!.basil;
      case 'pepper': return AppLocalizations.of(context)!.pepper;
      case 'cucumber': return AppLocalizations.of(context)!.cucumber;
      case 'strawberry': return AppLocalizations.of(context)!.strawberry;
      case 'spinach': return AppLocalizations.of(context)!.spinach;
      default: return plantKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allPlants = PlantConfig.defaultThresholds.keys.toList();
    final displayedPlants = allPlants.where((plant) {
      final localized = getLocalizedPlantName(context, plant);
      return localized.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.plantsInformation),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchPlants,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              itemCount: displayedPlants.length,
              itemBuilder: (context, index) {
                final plantName = displayedPlants[index];
                final thresholds = PlantConfig.defaultThresholds[plantName]!;

                return Card(
                  color: Theme.of(context).cardTheme.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 2,
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: Icon(
                          Icons.local_florist,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        getLocalizedPlantName(context, plantName),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            children: [
                              _buildThresholdRow(
                                icon: Icons.thermostat,
                                label: AppLocalizations.of(context)!.airTemperature,
                                min: thresholds['air temperature']?['min'],
                                max: thresholds['air temperature']?['max'],
                                unit: '°C',
                                color: Colors.orange,
                              ),
                              _buildThresholdRow(
                                icon: Icons.water_drop,
                                label: AppLocalizations.of(context)!.humidity,
                                min: thresholds['humidity']?['min'],
                                max: thresholds['humidity']?['max'],
                                unit: '%',
                                color: Colors.blue,
                              ),
                              _buildThresholdRow(
                                icon: Icons.grass,
                                label: AppLocalizations.of(context)!.soilMoisture,
                                min: thresholds['soil moisture']?['min'],
                                max: thresholds['soil moisture']?['max'],
                                unit: '%',
                                color: Colors.brown,
                              ),
                              _buildThresholdRow(
                                icon: Icons.thermostat_auto,
                                label: AppLocalizations.of(context)!.soilTemperature,
                                min: thresholds['soil temperature']?['min'],
                                max: thresholds['soil temperature']?['max'],
                                unit: '°C',
                                color: Colors.deepOrange,
                              ),
                              _buildThresholdRow(
                                icon: Icons.wb_sunny,
                                label: AppLocalizations.of(context)!.lightLevel,
                                min: thresholds['light level']?['min'],
                                max: thresholds['light level']?['max'],
                                unit: '%',
                                color: Colors.amber,
                              ),
                              _buildThresholdRow(
                                icon: Icons.air,
                                label: AppLocalizations.of(context)!.airQuality,
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            '${min?.toStringAsFixed(0)} - ${max?.toStringAsFixed(0)}$unit',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
