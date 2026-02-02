import sqlite3

DATABASE_NAME = "fitness_data.db"

def init_database():
    """Инициализация базы данных и создание таблиц"""
    conn = sqlite3.connect(DATABASE_NAME)
    cursor = conn.cursor()
    
    # Создание таблицы food
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS food (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            calories INTEGER NOT NULL,
            proteins REAL NOT NULL,
            fats REAL NOT NULL,
            carbs REAL NOT NULL,
            meal_type TEXT NOT NULL CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    
    # Создание таблицы exercises
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS exercises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            type TEXT NOT NULL,
            duration INTEGER NOT NULL,
            description TEXT
        )
    ''')
    
    # Создание таблицы users
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            height REAL,
            weight REAL,
            is_healthy BOOLEAN DEFAULT 1,
            daily_step_goal INTEGER DEFAULT 10000
        )
    ''')
    
    # Вставка начальных данных для упражнений
    cursor.execute('''
        INSERT OR IGNORE INTO exercises (name, type, duration, description) VALUES
        ('Приседания', 'Силовая', 10, 'Упражнение для ног'),
        ('Отжимания', 'Силовая', 5, 'Упражнение для груди и рук'),
        ('Планка', 'Статическая', 3, 'Укрепление корпуса'),
        ('Бег на месте', 'Кардио', 15, 'Кардио упражнение'),
        ('Скручивания', 'Пресс', 8, 'Упражнение для пресса')
    ''')
    
    # Создание пользователя по умолчанию
    cursor.execute('''
        INSERT OR IGNORE INTO users (id, height, weight, is_healthy, daily_step_goal)
        VALUES (1, 175.0, 70.0, 1, 10000)
    ''')
    
    conn.commit()
    conn.close()

# Для теста
if __name__ == "__main__":
    init_database()
    print("База данных создана успешно!")