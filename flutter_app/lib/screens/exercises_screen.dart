import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/exercise_card.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  final List<Map<String, dynamic>> exercises = const [
  {
    'name': 'Приседания',
    'type': 'Силовая',
    'duration': 10,
    'description': 'Упражнение для ног и ягодиц',
    'imageUrl':
        'https://images.unsplash.com/photo-1434682772747-f16d3ea162c3?auto=format&fit=crop&w=1200&q=60',
    'level': 'Начальный',
    'equipment': 'Без оборудования',
    'muscles': ['Квадрицепсы', 'Ягодицы', 'Кор'],
    'calories': 60,
    'stepsEquivalent': 1200,
    'instructions': [
      'Встаньте прямо, стопы на ширине плеч.',
      'Отведите таз назад и присядьте до параллели бедра с полом.',
      'Колени смотрят в сторону носков, спина ровная.',
      'Поднимитесь, напрягая ягодицы.'
    ],
    'commonMistakes': [
      'Колени заваливаются внутрь',
      'Округление спины',
      'Отрыв пяток от пола'
    ],
    'safetyTips': [
      'Начинайте без веса',
      'Держите корпус напряжённым',
      'Не делайте резких движений'
    ],
    'restSec': 45,
  },
  {
    'name': 'Отжимания',
    'type': 'Силовая',
    'duration': 5,
    'description': 'Упражнение для груди, плеч и трицепсов',
    'imageUrl':
        'https://images.unsplash.com/photo-1599058918144-1ffabb6ab9a0?auto=format&fit=crop&w=1200&q=60',
    'level': 'Начальный',
    'equipment': 'Без оборудования',
    'muscles': ['Грудные', 'Трицепсы', 'Плечи', 'Кор'],
    'calories': 35,
    'stepsEquivalent': 700,
    'instructions': [
      'Примите упор лёжа: ладони под плечами, корпус ровный.',
      'Опускайтесь, сгибая локти, до комфортной глубины.',
      'Держите корпус прямым, не прогибайтесь в пояснице.',
      'Выжмите себя вверх до исходного положения.'
    ],
    'commonMistakes': [
      'Провисает поясница',
      'Локти уходят слишком широко',
      'Неполная амплитуда без контроля'
    ],
    'safetyTips': [
      'Начните с отжиманий с колен при необходимости',
      'Держите шею нейтрально',
      'Работайте в контролируемом темпе'
    ],
    'restSec': 40,
  },
  {
    'name': 'Планка',
    'type': 'Статическая',
    'duration': 3,
    'description': 'Укрепление мышц кора',
    'imageUrl':
        'https://images.unsplash.com/photo-1518310383802-640c2de311b2?auto=format&fit=crop&w=1200&q=60',
    'level': 'Начальный',
    'equipment': 'Без оборудования',
    'muscles': ['Кор', 'Пресс', 'Поясница', 'Плечи'],
    'calories': 20,
    'stepsEquivalent': 400,
    'instructions': [
      'Встаньте в упор на предплечья: локти под плечами.',
      'Выпрямите ноги, опора на носки.',
      'Держите корпус прямым: голова–спина–таз в одной линии.',
      'Дышите ровно и удерживайте позицию.'
    ],
    'commonMistakes': [
      'Провисание таза',
      'Слишком высоко поднятый таз',
      'Задержка дыхания'
    ],
    'safetyTips': [
      'Начинайте с коротких подходов (20–30 сек)',
      'Не допускайте боли в пояснице',
      'Напрягайте пресс и ягодицы'
    ],
    'restSec': 30,
  },
  {
    'name': 'Бег на месте',
    'type': 'Кардио',
    'duration': 15,
    'description': 'Кардио упражнение для сжигания калорий',
    'imageUrl':
        'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=1200&q=60',
    'level': 'Начальный',
    'equipment': 'Без оборудования',
    'muscles': ['Ноги', 'Икры', 'Сердечно-сосудистая система'],
    'calories': 120,
    'stepsEquivalent': 2500,
    'instructions': [
      'Встаньте прямо, слегка согните колени.',
      'Начните мягко поднимать колени поочерёдно.',
      'Держите корпус ровно, работайте руками как при беге.',
      'Поддерживайте устойчивый темп в течение всей длительности.'
    ],
    'commonMistakes': [
      'Сильные удары пяткой об пол',
      'Сутулость и напряжённые плечи',
      'Слишком высокий темп без контроля дыхания'
    ],
    'safetyTips': [
      'Делайте разминку 2–3 минуты',
      'Приземляйтесь мягко на переднюю/среднюю часть стопы',
      'Если кружится голова — замедлитесь'
    ],
    'restSec': 60,
  },
  {
    'name': 'Скручивания',
    'type': 'Пресс',
    'duration': 8,
    'description': 'Упражнение для мышц пресса',
    'imageUrl':
        'https://images.unsplash.com/photo-1579758629938-03607ccdbaba?auto=format&fit=crop&w=1200&q=60',
    'level': 'Начальный',
    'equipment': 'Коврик (желательно)',
    'muscles': ['Прямые мышцы живота', 'Косые мышцы живота'],
    'calories': 45,
    'stepsEquivalent': 900,
    'instructions': [
      'Лягте на спину, согните колени, стопы на полу.',
      'Руки за головой или скрещены на груди (не тяните шею).',
      'Поднимайте верх корпуса, скручиваясь к коленям.',
      'Опускайтесь медленно, сохраняя контроль.'
    ],
    'commonMistakes': [
      'Тянут шею руками',
      'Рывки вместо контролируемого движения',
      'Слишком сильный прогиб в пояснице'
    ],
    'safetyTips': [
      'Держите подбородок слегка приподнятым',
      'Работайте прессом, а не шеей',
      'Если болит поясница — уменьшите амплитуду'
    ],
    'restSec': 40,
  },
  {
    'name': 'Выпады',
    'type': 'Силовая',
    'duration': 12,
    'description': 'Упражнение для ног и ягодиц',
    'imageUrl':
        'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=1200&q=60',
    'level': 'Средний',
    'equipment': 'Без оборудования',
    'muscles': ['Ягодицы', 'Квадрицепсы', 'Бицепс бедра', 'Кор'],
    'calories': 80,
    'stepsEquivalent': 1600,
    'instructions': [
      'Встаньте прямо, сделайте шаг вперёд одной ногой.',
      'Опуститесь вниз: переднее колено над стопой, заднее стремится к полу.',
      'Держите корпус ровно, взгляд вперёд.',
      'Оттолкнитесь передней ногой и вернитесь в исходное положение.'
    ],
    'commonMistakes': [
      'Колено уходит далеко за носок',
      'Завал корпуса вперёд',
      'Нестабильная постановка стоп'
    ],
    'safetyTips': [
      'Держите колено в линии стопы',
      'Начинайте с короткого шага для баланса',
      'Делайте движение медленно и контролируемо'
    ],
    'restSec': 50,
  },
];


  void _showExerciseModal(BuildContext context, Map<String, dynamic> exercise) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final name = (exercise['name'] ?? '') as String;
      final type = (exercise['type'] ?? '') as String;
      final duration = (exercise['duration'] ?? 0) as int;
      final desc = (exercise['description'] ?? '') as String;

      final imageUrl = exercise['imageUrl'] as String?;
      final level = exercise['level'] as String?;
      final equipment = exercise['equipment'] as String?;
      final calories = exercise['calories'] as int?;
      final stepsEq = exercise['stepsEquivalent'] as int?;
      final restSec = exercise['restSec'] as int?;

      final muscles = (exercise['muscles'] as List?)?.cast<String>() ?? const [];
      final instructions =
          (exercise['instructions'] as List?)?.cast<String>() ?? const [];
      final mistakes =
          (exercise['commonMistakes'] as List?)?.cast<String>() ?? const [];
      final safety =
          (exercise['safetyTips'] as List?)?.cast<String>() ?? const [];

      return SafeArea(
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          minChildSize: 0.55,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IMAGE
                    if (imageUrl != null && imageUrl.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // TITLE
                    Text(
                      name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // CHIPS
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          avatar: const Icon(Icons.category, size: 18),
                          label: Text(type),
                        ),
                        Chip(
                          avatar: const Icon(Icons.timer, size: 18),
                          label: Text('$duration мин'),
                        ),
                        if (level != null)
                          Chip(
                            avatar: const Icon(Icons.trending_up, size: 18),
                            label: Text(level),
                          ),
                        if (equipment != null)
                          Chip(
                            avatar: const Icon(Icons.handyman, size: 18),
                            label: Text(equipment),
                          ),
                        if (restSec != null)
                          Chip(
                            avatar: const Icon(Icons.pause_circle_outline, size: 18),
                            label: Text('Отдых: ${restSec}s'),
                          ),
                        if (calories != null)
                          Chip(
                            avatar: const Icon(Icons.local_fire_department, size: 18),
                            label: Text('~$calories ккал'),
                          ),
                        if (stepsEq != null)
                          Chip(
                            avatar: const Icon(Icons.directions_walk, size: 18),
                            label: Text('~$stepsEq шагов'),
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // DESCRIPTION
                    Text(
                      desc,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),

                    const SizedBox(height: 16),

                    // MUSCLES
                    if (muscles.isNotEmpty) ...[
                      const _SectionTitle('Целевые мышцы'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: muscles
                            .map((m) => Chip(
                                  label: Text(m),
                                  avatar: const Icon(Icons.circle, size: 10),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // INSTRUCTIONS
                    if (instructions.isNotEmpty) ...[
                      const _SectionTitle('Как выполнять'),
                      const SizedBox(height: 8),
                      ...instructions.asMap().entries.map((e) {
                        final i = e.key + 1;
                        final text = e.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$i.', style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(text)),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                    ],

                    // MISTAKES
                    if (mistakes.isNotEmpty) ...[
                      const _SectionTitle('Частые ошибки'),
                      const SizedBox(height: 8),
                      ...mistakes.map((m) => _BulletRow(
                            icon: Icons.error_outline,
                            text: m,
                          )),
                      const SizedBox(height: 16),
                    ],

                    // SAFETY
                    if (safety.isNotEmpty) ...[
                      const _SectionTitle('Безопасность'),
                      const SizedBox(height: 8),
                      ...safety.map((s) => _BulletRow(
                            icon: Icons.health_and_safety_outlined,
                            text: s,
                          )),
                      const SizedBox(height: 16),
                    ],

                    // ACTIONS
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            label: const Text('Закрыть'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Пока заглушка, потом можно запуск таймера/тренировки
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Начать: $name')),
                              );
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Начать'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _BulletRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
