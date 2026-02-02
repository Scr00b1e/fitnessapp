import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> loadUserData() async {
    try {
      final response = await http.get(Uri.parse('${Constants.baseUrl}/user'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _user = User.fromJson(data);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> updateUserData({
    double? height,
    double? weight,
    bool? isHealthy,
    int? dailyStepGoal,
  }) async {
    try {
      final currentUser = _user ?? User(isHealthy: true, dailyStepGoal: 10000);
      
      final updatedUser = User(
        height: height ?? currentUser.height,
        weight: weight ?? currentUser.weight,
        isHealthy: isHealthy ?? currentUser.isHealthy,
        dailyStepGoal: dailyStepGoal ?? currentUser.dailyStepGoal,
      );
      
      final response = await http.put(
        Uri.parse('${Constants.baseUrl}/user'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedUser.toJson()),
      );
      
      if (response.statusCode == 200) {
        _user = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}