import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/exercise_card.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  final List<Map<String, dynamic>> exercises = const [
    {
      'name': 'Приседания',
      'type': 'Силовая',
      'duration': 10,
      'description': 'Упражнение для ног и ягодиц'
    },
    {
      'name': 'Отжимания',
      'type': 'Силовая',
      'duration': 5,
      'description': 'Упражнение для груди, плеч и трицепсов'
    },
    {
      'name': 'Планка',
      'type': 'Статическая',
      'duration': 3,
      'description': 'Укрепление мышц кора'
    },
    {
      'name': 'Бег на месте',
      'type': 'Кардио',
      'duration': 15,
      'description': 'Кардио упражнение для сжигания калорий'
    },
    {
      'name': 'Скручивания',
      'type': 'Пресс',
      'duration': 8,
      'description': 'Упражнение для мышц пресса'
    },
    {
      'name': 'Выпады',
      'type': 'Силовая',
      'duration': 12,
      'description': 'Упражнение для ног и ягодиц'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Физические упражнения'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ExerciseCard(
            name: exercise['name'],
            type: exercise['type'],
            duration: exercise['duration'],
            description: exercise['description'],
          );
        },
      ),
    );
  }
}