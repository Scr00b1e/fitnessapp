import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentSteps;
  final int goalSteps;
  final String period;

  // 🔥 Fake calories (можно передавать параметром, но для MVP посчитаем тут)
  const StepProgressIndicator({
    super.key,
    required this.currentSteps,
    required this.goalSteps,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final stepsProgress = (currentSteps / goalSteps).clamp(0.0, 1.0);

    // ✅ Фейковые калории: например 0.04 ккал на шаг (просто заглушка)
    final fakeCalories = (currentSteps * 0.04).round();
    // ✅ Фейковый прогресс калорий: пусть "цель" 500 ккал
    final caloriesGoal = 500;
    final caloriesProgress = (fakeCalories / caloriesGoal).clamp(0.0, 1.0);

    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // OUTER CIRCLE - Steps
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: stepsProgress,
              strokeWidth: 14,
              backgroundColor: Colors.grey.shade200,
              color: Colors.blue,
              strokeCap: StrokeCap.round,
            ),
          ),

          // INNER CIRCLE - Calories 🔴
          SizedBox(
            width: 140,
            height: 140,
            child: CircularProgressIndicator(
              value: caloriesProgress,
              strokeWidth: 12,
              backgroundColor: Colors.red.shade50,
              color: Colors.red,
              strokeCap: StrokeCap.round,
            ),
          ),

          // CENTER TEXT
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$currentSteps',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Text(
                'шагов',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                '$fakeCalories ккал',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
