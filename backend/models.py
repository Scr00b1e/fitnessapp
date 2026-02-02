from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class FoodItem(BaseModel):
    name: str
    calories: int
    proteins: float
    fats: float
    carbs: float
    meal_type: str  # breakfast, lunch, dinner, snack

class FoodItemDB(FoodItem):
    id: int
    created_at: datetime

class Exercise(BaseModel):
    name: str
    type: str
    duration: int
    description: Optional[str] = None

class UserSettings(BaseModel):
    height: Optional[float] = None
    weight: Optional[float] = None
    is_healthy: bool = True
    daily_step_goal: int = 10000