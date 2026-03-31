import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/plant_repository.dart';
import 'plants_state.dart';

class PlantsCubit extends Cubit<PlantsState> {
  final PlantRepository _repository;

  PlantsCubit(this._repository) : super(PlantsInitial());

  Future<void> fetchPlants() async {
    emit(PlantsLoading());
    try {
      final plants = await _repository.getAllPlants();
      emit(PlantsSuccess(plants: plants));
    } catch (e) {
      emit(PlantsFailure(e.toString()));
    }
  }

  void searchPlants(String query, {required Map<String, String> localizedNames}) {
    if (state is PlantsSuccess) {
      final currentState = state as PlantsSuccess;
      
      if (query.isEmpty) {
        emit(PlantsSuccess(plants: currentState.plants, filtered: currentState.plants));
        return;
      }

      final filtered = currentState.plants.where((plant) {
        // Search by both key (English) and translated name
        final localized = localizedNames[plant.id] ?? plant.id;
        return plant.id.toLowerCase().contains(query.toLowerCase()) ||
               localized.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(PlantsSuccess(plants: currentState.plants, filtered: filtered));
    }
  }
}
