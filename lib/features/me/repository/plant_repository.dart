import '../../../core/utils/plant_types.dart';
import '../model/plant_model.dart';

class PlantRepository {
  /// Fetch all available plants from configuration
  Future<List<PlantModel>> getAllPlants() async {
    // Simulated delay for future API support
    await Future.delayed(const Duration(milliseconds: 100));
    
    final data = PlantConfig.defaultThresholds;
    return data.entries.map((e) => PlantModel.fromMap(e.key, e.value)).toList();
  }

  /// Specialized search logic to handle both ID and localized name (optional at repo level)
  Future<List<PlantModel>> searchPlants(String query) async {
    final all = await getAllPlants();
    if (query.isEmpty) return all;
    
    return all.where((p) => p.id.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
