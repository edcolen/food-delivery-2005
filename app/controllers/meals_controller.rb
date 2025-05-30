require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repo)
    @meal_repo = meal_repo
    @meals_view = MealsView.new
  end

  def add
    name = @meals_view.ask_user_for(:name)
    price = @meals_view.ask_user_for(:price).to_i
    meal = Meal.new(name:, price:)
    @meal_repo.create(meal)
    list
  end

  def edit
    meal = select_meal
    meal.name = @meals_view.edit('name', meal.name)
    meal.price = @meals_view.edit('price', meal.price).to_i
    @meal_repo.save_csv
    list
  end

  def remove
    meal = select_meal
    @meal_repo.destroy(meal.id)
    list
  end

  def list
    meals = @meal_repo.all
    @meals_view.display(meals)
  end

  def select_meal
    meals = @meal_repo.all
    @meals_view.display(meals)
    index = @meals_view.ask_user_for_index
    return meals[index]
  end
end
