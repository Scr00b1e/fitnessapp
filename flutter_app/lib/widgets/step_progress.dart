import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentSteps;
  final int goalSteps;
  final String period;

  const StepProgressIndicator({
    super.key,
    required this.currentSteps,
    required this.goalSteps,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    double progress = goalSteps > 0 ? currentSteps / goalSteps : 0;
    if (progress > 1) progress = 1;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            '${_getPeriodText(period)} шаги',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 15,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress >= 1 ? Colors.green : Colors.blue,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    currentSteps.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '/ $goalSteps',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${(progress * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getPeriodText(String period) {
    switch (period) {
      case 'day':
        return 'Дневная норма';
      case 'week':
        return 'Недельная норма';
      case 'month':
        return 'Месячная норма';
      default:
        return 'Дневная норма';
    }
  }
}