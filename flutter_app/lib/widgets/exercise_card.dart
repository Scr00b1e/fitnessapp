import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String type;
  final int duration;
  final String description;

  const ExerciseCard({
    super.key,
    required this.name,
    required this.type,
    required this.duration,
    required this.description,
  });

  Color _getExerciseColor(String type) {
    switch (type.toLowerCase()) {
      case 'силовая':
        return Colors.red[100]!;
      case 'кардио':
        return Colors.blue[100]!;
      case 'статическая':
        return Colors.green[100]!;
      case 'пресс':
        return Colors.orange[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getExerciseColor(type),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '$duration минут',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}