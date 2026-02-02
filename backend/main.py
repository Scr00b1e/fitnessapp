from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import sqlite3
from datetime import datetime
from models import FoodItem, Exercise, UserSettings
import database

app = FastAPI(title="Fitness App Backend")

# Настройка CORS для Flutter приложения
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Разрешаем все домены (только для разработки!)
    allow_credentials=True,
    allow_methods=["*"],  # Разрешаем все методы (GET, POST, PUT, DELETE)
    allow_headers=["*"],  # Разрешаем все заголовки
)

# Инициализация базы данных при запуске
database.init_database()

# ========== FOOD API ==========

@app.get("/food")
def get_food_items():
    """Получить все продукты питания"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM food ORDER BY created_at DESC")
    items = cursor.fetchall()
    
    conn.close()
    
    return [
        {
            "id": item[0],
            "name": item[1],
            "calories": item[2],
            "proteins": item[3],
            "fats": item[4],
            "carbs": item[5],
            "meal_type": item[6],
            "created_at": item[7]
        }
        for item in items
    ]

@app.post("/food")
def add_food_item(food: FoodItem):
    """Добавить новый продукт питания"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute('''
        INSERT INTO food (name, calories, proteins, fats, carbs, meal_type)
        VALUES (?, ?, ?, ?, ?, ?)
    ''', (food.name, food.calories, food.proteins, food.fats, food.carbs, food.meal_type))
    
    conn.commit()
    item_id = cursor.lastrowid
    conn.close()
    
    return {"id": item_id, "message": "Food item added successfully"}

@app.put("/food/{item_id}")
def update_food_item(item_id: int, food: FoodItem):
    """Обновить продукт питания"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute('''
        UPDATE food 
        SET name=?, calories=?, proteins=?, fats=?, carbs=?, meal_type=?
        WHERE id=?
    ''', (food.name, food.calories, food.proteins, food.fats, food.carbs, food.meal_type, item_id))
    
    if cursor.rowcount == 0:
        conn.close()
        raise HTTPException(status_code=404, detail="Food item not found")
    
    conn.commit()
    conn.close()
    
    return {"message": "Food item updated successfully"}

@app.delete("/food/{item_id}")
def delete_food_item(item_id: int):
    """Удалить продукт питания"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute("DELETE FROM food WHERE id=?", (item_id,))
    
    if cursor.rowcount == 0:
        conn.close()
        raise HTTPException(status_code=404, detail="Food item not found")
    
    conn.commit()
    conn.close()
    
    return {"message": "Food item deleted successfully"}

# ========== EXERCISES API ==========

@app.get("/exercises")
def get_exercises():
    """Получить все упражнения"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM exercises")
    exercises = cursor.fetchall()
    
    conn.close()
    
    return [
        {
            "id": ex[0],
            "name": ex[1],
            "type": ex[2],
            "duration": ex[3],
            "description": ex[4]
        }
        for ex in exercises
    ]

# ========== USER API ==========

@app.get("/user")
def get_user():
    """Получить данные пользователя"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM users WHERE id=1")
    user = cursor.fetchone()
    
    conn.close()
    
    if user:
        return {
            "height": user[1],
            "weight": user[2],
            "is_healthy": bool(user[3]),
            "daily_step_goal": user[4]
        }
    return {}

@app.put("/user")
def update_user(settings: UserSettings):
    """Обновить данные пользователя"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute('''
        UPDATE users 
        SET height=?, weight=?, is_healthy=?, daily_step_goal=?
        WHERE id=1
    ''', (settings.height, settings.weight, settings.is_healthy, settings.daily_step_goal))
    
    conn.commit()
    conn.close()
    
    return {"message": "User settings updated successfully"}

# ========== STATS API ==========

@app.get("/stats/steps/{period}")
def get_step_stats(period: str):  # period: day, week, month
    """Получить статистику шагов (mock данные)"""
    # Строго по UX-схеме: день/неделя/месяц
    if period == "day":
        return {"steps": 8423, "goal": 10000, "period": "day"}
    elif period == "week":
        return {"steps": 58900, "goal": 70000, "period": "week"}
    else:  # month
        return {"steps": 245000, "goal": 300000, "period": "month"}

@app.get("/stats/nutrition")
def get_nutrition_stats():
    """Получить статистику КБЖУ (рассчитывается из базы)"""
    conn = sqlite3.connect(database.DATABASE_NAME)
    cursor = conn.cursor()
    
    cursor.execute('''
        SELECT 
            SUM(calories) as total_calories,
            SUM(proteins) as total_proteins,
            SUM(fats) as total_fats,
            SUM(carbs) as total_carbs
        FROM food 
        WHERE date(created_at) = date('now')
    ''')
    
    result = cursor.fetchone()
    conn.close()
    
    return {
        "calories": result[0] or 0,
        "proteins": result[1] or 0,
        "fats": result[2] or 0,
        "carbs": result[3] or 0
    }

if __name__ == "__main__":
    import uvicorn
    import socket
    
    # Получаем IP адрес компьютера
    def get_local_ip():
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(("8.8.8.8", 80))
            ip = s.getsockname()[0]
            s.close()
            return ip
        except:
            return "localhost"

    local_ip = get_local_ip()
    
    print("=" * 50)
    print("ФИТНЕС-ПРИЛОЖЕНИЕ - СЕРВЕР")
    print("=" * 50)
    print("Сервер запускается...")
    print("Доступные адреса:")
    print(f"1. http://localhost:8000")
    print(f"2. http://127.0.0.1:8000")
    print(f"3. http://{local_ip}:8000")
    print("")
    print("Документация API: http://localhost:8000/docs")
    print("=" * 50)
    print("ВАЖНО! Для работы приложения используйте IP: ", local_ip)
    print("Укажите этот IP в файле lib/utils/constants.dart")
    print("=" * 50)
    print("Для остановки сервера нажмите Ctrl+C")
    print("=" * 50)
    
    # Запуск сервера через строку импорта (убираем предупреждение)
    uvicorn.run(
        "main:app",  # Используем строку импорта вместо объекта
        host="0.0.0.0",
        port=8000,
        reload=True
    )