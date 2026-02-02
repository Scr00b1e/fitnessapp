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

  void _showExerciseModal(BuildContext context, Map<String, dynamic> exercise) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Wrap(
            children: [
              Text(
                exercise['name'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Chip(
                    label: Text(exercise['type']),
                    avatar: const Icon(Icons.fitness_center, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    label: Text('${exercise['duration']} мин'),
                    avatar: const Icon(Icons.timer, size: 18),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                exercise['description'],
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check),
                  label: const Text('Понятно'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _showExerciseModal(context, exercise),
              child: ExerciseCard(
                name: exercise['name'],
                type: exercise['type'],
                duration: exercise['duration'],
                description: exercise['description'],
              ),
            ),
          );
        },
      ),
    );
  }
}
