import '../model/plant_model.dart';

abstract class PlantsState {}

class PlantsInitial extends PlantsState {}

class PlantsLoading extends PlantsState {}

class PlantsSuccess extends PlantsState {
  final List<PlantModel> plants;
  late final List<PlantModel> filteredPlants;

  PlantsSuccess({required this.plants, List<PlantModel>? filtered}) {
    filteredPlants = filtered ?? plants;
  }
}

class PlantsFailure extends PlantsState {
  final String error;
  PlantsFailure(this.error);
}
