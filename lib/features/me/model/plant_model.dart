class PlantModel {
  final String id; // The key (e.g., Tomato)
  final Map<String, PlantThreshold> thresholds;

  PlantModel({
    required this.id,
    required this.thresholds,
  });

  factory PlantModel.fromMap(String id, Map<String, dynamic> data) {
    Map<String, PlantThreshold> thresholdMap = {};
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        thresholdMap[key] = PlantThreshold.fromMap(value);
      }
    });
    return PlantModel(id: id, thresholds: thresholdMap);
  }

  PlantThreshold? getThreshold(String key) => thresholds[key];
}

class PlantThreshold {
  final double min;
  final double max;

  PlantThreshold({required this.min, required this.max});

  factory PlantThreshold.fromMap(Map<String, dynamic> map) {
    return PlantThreshold(
      min: (map['min'] as num?)?.toDouble() ?? 0.0,
      max: (map['max'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
