import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import '../../view_model/plants_cubit.dart';
import '../../view_model/plants_state.dart';
import '../../model/plant_model.dart';

class PlantsInfoView extends StatelessWidget {
  const PlantsInfoView({super.key});

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: l10n.plantsInformation),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.searchPlants,
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                // Fetch localized names for filtering
                final names = <String, String>{};
                final state = context.read<PlantsCubit>().state;
                if (state is PlantsSuccess) {
                  for (var p in state.plants) {
                    names[p.id] = getLocalizedPlantName(context, p.id);
                  }
                }
                context.read<PlantsCubit>().searchPlants(value, localizedNames: names);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PlantsCubit, PlantsState>(
              builder: (context, state) {
                if (state is PlantsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PlantsSuccess) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: state.filteredPlants.length,
                    itemBuilder: (context, index) {
                      return _PlantCard(plant: state.filteredPlants[index]);
                    },
                  );
                } else if (state is PlantsFailure) {
                  return Center(child: Text(state.error));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PlantCard extends StatelessWidget {
  final PlantModel plant;
  const _PlantCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final parent = context.findAncestorWidgetOfExactType<PlantsInfoView>()!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Icon(Icons.local_florist, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(
          parent.getLocalizedPlantName(context, plant.id),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildRow(context, Icons.thermostat, l10n.airTemperature, plant.getThreshold('air temperature'), '°C', Colors.orange),
                _buildRow(context, Icons.water_drop, l10n.humidity, plant.getThreshold('humidity'), '%', Colors.blue),
                _buildRow(context, Icons.grass, l10n.soilMoisture, plant.getThreshold('soil moisture'), '%', Colors.brown),
                _buildRow(context, Icons.thermostat_auto, l10n.soilTemperature, plant.getThreshold('soil temperature'), '°C', Colors.deepOrange),
                _buildRow(context, Icons.wb_sunny, l10n.lightLevel, plant.getThreshold('light level'), '%', Colors.amber),
                _buildRow(context, Icons.air, l10n.airQuality, plant.getThreshold('air quality'), ' ppm', Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, IconData icon, String label, PlantThreshold? threshold, String unit, Color color) {
    if (threshold == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
          Text('${threshold.min.toStringAsFixed(0)} - ${threshold.max.toStringAsFixed(0)}$unit',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
