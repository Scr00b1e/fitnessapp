class User {
  final double? height;
  final double? weight;
  final bool isHealthy;
  final int dailyStepGoal;

  User({
    this.height,
    this.weight,
    required this.isHealthy,
    required this.dailyStepGoal,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      isHealthy: json['is_healthy'] ?? true,
      dailyStepGoal: json['daily_step_goal'] ?? 10000,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'is_healthy': isHealthy,
      'daily_step_goal': dailyStepGoal,
    };
  }
}