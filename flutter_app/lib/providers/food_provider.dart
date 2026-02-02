import 'package:flutter/foundation.dart';
import '../models/food.dart';
import '../services/food_service.dart';

class FoodProvider with ChangeNotifier {
  final FoodService _foodService = FoodService();
  List<FoodItem> _foodItems = [];
  Map<String, dynamic> _nutritionStats = {};

  List<FoodItem> get foodItems => _foodItems;
  Map<String, dynamic> get nutritionStats => _nutritionStats;

  // Группировка по типам приема пищи
  List<FoodItem> get breakfastItems =>
      _foodItems.where((item) => item.mealType == 'breakfast').toList();
  
  List<FoodItem> get lunchItems =>
      _foodItems.where((item) => item.mealType == 'lunch').toList();
  
  List<FoodItem> get dinnerItems =>
      _foodItems.where((item) => item.mealType == 'dinner').toList();
  
  List<FoodItem> get snackItems =>
      _foodItems.where((item) => item.mealType == 'snack').toList();

  Future<void> loadFoodItems() async {
    try {
      _foodItems = await _foodService.getFoodItems();
      await loadNutritionStats();
      notifyListeners();
    } catch (e) {
      print('Error loading food items: $e');
    }
  }

  Future<void> loadNutritionStats() async {
    try {
      _nutritionStats = await _foodService.getNutritionStats();
      notifyListeners();
    } catch (e) {
      print('Error loading nutrition stats: $e');
    }
  }

  Future<void> addFood(FoodItem item) async {
    try {
      await _foodService.addFoodItem(item);
      await loadFoodItems();
    } catch (e) {
      print('Error adding food item: $e');
    }
  }

  Future<void> updateFood(int id, FoodItem item) async {
    try {
      await _foodService.updateFoodItem(id, item);
      await loadFoodItems();
    } catch (e) {
      print('Error updating food item: $e');
    }
  }

  Future<void> deleteFood(int id) async {
    try {
      await _foodService.deleteFoodItem(id);
      await loadFoodItems();
    } catch (e) {
      print('Error deleting food item: $e');
    }
  }
}