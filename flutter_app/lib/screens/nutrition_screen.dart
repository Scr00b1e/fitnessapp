import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/models/food.dart';
import 'package:fitness_app/providers/food_provider.dart';
import 'package:fitness_app/widgets/food_card.dart';
import 'package:fitness_app/widgets/nutrition_chart.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем данные с сервера при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FoodProvider>(context, listen: false).loadFoodItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final stats = foodProvider.nutritionStats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Питание (КБЖУ)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddFoodDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Блок КБЖУ (строго по UX-схеме)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Дневные макронутриенты',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNutrientCard('Калории', '${stats['calories'] ?? 0}', 'ккал'),
                          _buildNutrientCard('Белки', '${stats['proteins']?.toStringAsFixed(1) ?? 0}', 'г'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNutrientCard('Жиры', '${stats['fats']?.toStringAsFixed(1) ?? 0}', 'г'),
                          _buildNutrientCard('Углеводы', '${stats['carbs']?.toStringAsFixed(1) ?? 0}', 'г'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Диаграмма КБЖУ
              NutritionChart(stats: stats),
              
              const SizedBox(height: 20),
              
              // Строго по UX-схеме: 4 раздела питания
              _buildMealSection('Завтрак', foodProvider.breakfastItems, 'breakfast'),
              _buildMealSection('Обед', foodProvider.lunchItems, 'lunch'),
              _buildMealSection('Ужин', foodProvider.dinnerItems, 'dinner'),
              _buildMealSection('Снэки', foodProvider.snackItems, 'snack'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientCard(String title, String value, String unit) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          unit,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMealSection(String title, List<FoodItem> items, String mealType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blue),
              onPressed: () => _showAddFoodDialog(context, mealType: mealType),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Нет данных. Добавьте продукты.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...items.map((food) => FoodCard(
                food: food,
                onEdit: () => _showEditFoodDialog(context, food),
                onDelete: () => _deleteFood(context, food.id),
              )),
      ],
    );
  }

  void _showAddFoodDialog(BuildContext context, {String? mealType}) {
    showDialog(
      context: context,
      builder: (context) => AddEditFoodDialog(
        mealType: mealType ?? 'breakfast',
        onSave: (food) {
          Provider.of<FoodProvider>(context, listen: false).addFood(food);
        },
      ),
    );
  }

  void _showEditFoodDialog(BuildContext context, FoodItem food) {
    showDialog(
      context: context,
    builder: (context) => AddEditFoodDialog(
       mealType: 'breakfast', // или другая логика выбора типа
       onSave: (food) {
         Provider.of<FoodProvider>(context, listen: false).addFood(food);
        },
      ),
    );
  }

  void _deleteFood(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить продукт?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<FoodProvider>(context, listen: false)
                  .deleteFood(id);
              Navigator.pop(context);
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class AddEditFoodDialog extends StatefulWidget {
  final FoodItem? food;
  final String mealType;
  final Function(FoodItem) onSave;

  const AddEditFoodDialog({
    super.key,
    this.food,
    required this.mealType,
    required this.onSave,
  });

  @override
  State<AddEditFoodDialog> createState() => _AddEditFoodDialogState();
}

class _AddEditFoodDialogState extends State<AddEditFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinsController = TextEditingController();
  final _fatsController = TextEditingController();
  final _carbsController = TextEditingController();
  String _selectedMealType = 'breakfast';

  @override
  void initState() {
    super.initState();
    _selectedMealType = widget.food?.mealType ?? widget.mealType;
    
    if (widget.food != null) {
      _nameController.text = widget.food!.name;
      _caloriesController.text = widget.food!.calories.toString();
      _proteinsController.text = widget.food!.proteins.toString();
      _fatsController.text = widget.food!.fats.toString();
      _carbsController.text = widget.food!.carbs.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.food == null ? 'Добавить продукт' : 'Редактировать продукт'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Название продукта'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(labelText: 'Калории (ккал)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите количество калорий';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Введите число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _proteinsController,
                      decoration: const InputDecoration(labelText: 'Белки (г)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _fatsController,
                      decoration: const InputDecoration(labelText: 'Жиры (г)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      decoration: const InputDecoration(labelText: 'Углеводы (г)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _selectedMealType,
                decoration: const InputDecoration(labelText: 'Прием пищи'),
                items: const [
                  DropdownMenuItem(value: 'breakfast', child: Text('Завтрак')),
                  DropdownMenuItem(value: 'lunch', child: Text('Обед')),
                  DropdownMenuItem(value: 'dinner', child: Text('Ужин')),
                  DropdownMenuItem(value: 'snack', child: Text('Снэк')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedMealType = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _saveFood,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  void _saveFood() {
    if (_formKey.currentState!.validate()) {
      final food = FoodItem(
        id: widget.food?.id ?? 0,
        name: _nameController.text,
        calories: int.parse(_caloriesController.text),
        proteins: double.parse(_proteinsController.text),
        fats: double.parse(_fatsController.text),
        carbs: double.parse(_carbsController.text),
        mealType: _selectedMealType,
        createdAt: DateTime.now(),
      );
      
      widget.onSave(food);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinsController.dispose();
    _fatsController.dispose();
    _carbsController.dispose();
    super.dispose();
  }
}