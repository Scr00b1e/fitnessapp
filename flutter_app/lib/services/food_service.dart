import '../models/food.dart';
import 'api_client.dart';

class FoodService {
  final ApiClient _client = ApiClient();

  Future<List<FoodItem>> getFoodItems() async {
    try {
      final response = await _client.get('/food');
      if (response is List) {
        return response.map((item) => FoodItem.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching food items: $e');
      return [];
    }
  }

  Future<void> addFoodItem(FoodItem item) async {
    await _client.post('/food', item.toJson());
  }

  Future<void> updateFoodItem(int id, FoodItem item) async {
    await _client.put('/food/$id', item.toJson());
  }

  Future<void> deleteFoodItem(int id) async {
    await _client.delete('/food/$id');
  }

  Future<Map<String, dynamic>> getNutritionStats() async {
    return await _client.get('/stats/nutrition');
  }
}