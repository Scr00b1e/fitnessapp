import 'package:flutter/material.dart';

class NutritionChart extends StatelessWidget {
  final Map<String, dynamic> stats;

  const NutritionChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final calories = (stats['calories'] as num?)?.toDouble() ?? 0;
    final proteins = (stats['proteins'] as num?)?.toDouble() ?? 0;
    final fats = (stats['fats'] as num?)?.toDouble() ?? 0;
    final carbs = (stats['carbs'] as num?)?.toDouble() ?? 0;

    final total = proteins + fats + carbs;
    final proteinPercent = total > 0 ? (proteins / total * 100).toInt() : 0;
    final fatPercent = total > 0 ? (fats / total * 100).toInt() : 0;
    final carbPercent = total > 0 ? (carbs / total * 100).toInt() : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Состав макронутриентов',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: proteinPercent / 100,
                            strokeWidth: 15,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          '$proteinPercent%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text('Белки'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: fatPercent / 100,
                            strokeWidth: 15,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '$fatPercent%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text('Жиры'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: carbPercent / 100,
                            strokeWidth: 15,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          '$carbPercent%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text('Углеводы'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Всего калорий: ${calories.toInt()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}