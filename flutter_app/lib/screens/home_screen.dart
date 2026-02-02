import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/step_progress.dart';
import 'package:fitness_app/services/weather_service.dart';
import 'package:fitness_app/models/weather_now.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedPeriod = 'day'; // Строго по UX-схеме: день/неделя/месяц

  late final WeatherService _weatherService;
  late Future<WeatherNow> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService();
    _weatherFuture = _weatherService.fetchBishkekNow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фитнес Приложение'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Кольцевой индикатор шагов (строго по UX-схеме)
              Center(
                child: StepProgressIndicator(
                  currentSteps: 8423,
                  goalSteps: 10000,
                  period: _selectedPeriod,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Два информационных блока (строго по UX-схеме)
              Row(
                children: [
                  Expanded(
                    child: FutureBuilder<WeatherNow>(
                      future: _weatherFuture,
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return _buildInfoCard(
                            icon: Icons.cloud,
                            title: 'Погода',
                            subtitle: 'Загрузка...',
                            color: Colors.blue[50]!,
                          );
                        }

                        if (snap.hasError) {
                          return _buildInfoCard(
                            icon: Icons.cloud_off,
                            title: 'Погода',
                            subtitle: 'Ошибка загрузки',
                            color: Colors.blue[50]!,
                          );
                        }

                        final w = snap.data!;
                        final desc = weatherCodeToRu(w.weatherCode);
                        final temp = w.temperatureC.toStringAsFixed(0);

                        return _buildInfoCard(
                          icon: Icons.cloud,
                          title: 'Погода (Бишкек)',
                          subtitle: '$temp°C, $desc',
                          color: Colors.blue[50]!,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.newspaper,
                      title: 'Новости города',
                      subtitle: 'Фитнес-залы открыты',
                      color: Colors.green[50]!,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Текст "Ударный день..." (строго по UX-схеме)
              const Text(
                'Ударный день закрытия дневной нормы шагов',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Маршруты активности (заглушка)
              _buildActivityRoutes(),
              
              const SizedBox(height: 20),
              
              // Переключение периодов (строго по UX-схеме)
              _buildPeriodSelector(),
              
              const SizedBox(height: 20),
              
              // График/диаграмма (заглушка)
              _buildChartPlaceholder(),
              
              const SizedBox(height: 20),
              
              // Кнопка перехода на страницу шагов
              ElevatedButton.icon(
                onPressed: () {
                  // Навигация на отдельный экран шагов
                  _showStepsAndClubScreen();
                },
                icon: const Icon(Icons.directions_walk),
                label: const Text('Шаги и клуб занятий'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRoutes() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Маршруты активности',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Парк Горького - 5.2 км'),
          Text('Набережная - 3.7 км'),
          Text('Стадион - 2.1 км'),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment<String>(
          value: 'day',
          label: Text('День'),
          icon: Icon(Icons.today),
        ),
        ButtonSegment<String>(
          value: 'week',
          label: Text('Неделя'),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment<String>(
          value: 'month',
          label: Text('Месяц'),
          icon: Icon(Icons.calendar_month),
        ),
      ],
      selected: {_selectedPeriod},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          _selectedPeriod = newSelection.first;
        });
      },
    );
  }

  Widget _buildChartPlaceholder() {
  // Фейковые данные под каждый период (0..100)
    final Map<String, List<int>> fakeData = {
      'day':   [20, 35, 55, 40, 70, 60, 85, 45, 30, 65, 50, 90],
      'week':  [45, 60, 30, 80, 70, 55, 65],
      'month': [30, 55, 40, 60, 35, 75, 50, 80, 45, 65, 90, 70],
    };

    final Map<String, List<String>> labels = {
      'day':   ['6', '8', '10', '12', '14', '16', '18', '20', '22', '24', '2', '4'],
      'week':  ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'],
      'month': ['1', '4', '7', '10', '13', '16', '19', '22', '25', '28', '30', '31'],
    };

    final data = fakeData[_selectedPeriod] ?? const [];
    final xLabels = labels[_selectedPeriod] ?? const [];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'График активности',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            _selectedPeriod == 'day'
                ? 'Почасовая активность (фейк)'
                : _selectedPeriod == 'week'
                    ? 'Активность по дням недели (фейк)'
                    : 'Активность за месяц (фейк)',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(data.length, (i) {
                final v = data[i].clamp(0, 100); // 0..100
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // BAR
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          height: 1.3 * v.toDouble(), // 0..130px
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // LABEL
                        Text(
                          i < xLabels.length ? xLabels[i] : '',
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 8),

          // Легенда/подсказка
          Row(
            children: const [
              Icon(Icons.info_outline, size: 16, color: Colors.grey),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Данные демонстрационные. Позже подключим реальные шаги/тренировки.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _showStepsAndClubScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Шаги и клуб занятий',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // Данные из Samsung Health / Apple Fitness (заглушка)
              _buildHealthDataCard(
                'Samsung Health',
                Icons.phone_android,
                'Шаги: 8423\nДистанция: 6.7 км',
              ),
              
              const SizedBox(height: 10),
              
              _buildHealthDataCard(
                'Apple Fitness',
                Icons.phone_iphone,
                'Шаги: 7980\nДистанция: 6.3 км',
              ),
              
              const SizedBox(height: 20),
              
              const Text(
                'Занятия',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              
              Expanded(
                child: ListView(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.directions_run),
                      title: Text('Утренняя пробежка'),
                      subtitle: Text('30 минут, 300 ккал'),
                    ),
                    ListTile(
                      leading: Icon(Icons.fitness_center),
                      title: Text('Силовая тренировка'),
                      subtitle: Text('45 минут, 450 ккал'),
                    ),
                    ListTile(
                      leading: Icon(Icons.directions_bike),
                      title: Text('Велотренажер'),
                      subtitle: Text('20 минут, 200 ккал'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHealthDataCard(String title, IconData icon, String data) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(data),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
  
  String weatherCodeToRu(int code) {
  switch (code) {
    case 0:
      return 'Ясно';
    case 1:
    case 2:
      return 'Малооблачно';
    case 3:
      return 'Облачно';
    case 45:
    case 48:
      return 'Туман';
    case 51:
    case 53:
    case 55:
      return 'Морось';
    case 61:
    case 63:
    case 65:
      return 'Дождь';
    case 71:
    case 73:
    case 75:
      return 'Снег';
    case 80:
    case 81:
    case 82:
      return 'Ливни';
    case 95:
    case 96:
    case 99:
      return 'Гроза';
    default:
      return 'Неизвестно';
  }
}
}