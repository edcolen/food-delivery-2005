require_relative "../models/order"
require_relative "../repositories/base_repository"

class OrderRepository < BaseRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    super(csv_file)
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    row[:delivered] = row[:delivered] == "true"
    row[:meal] = @meal_repository.find(row[:meal_id].to_i)
    row[:customer] = @customer_repository.find(row[:customer_id].to_i)
    row[:employee] = @employee_repository.find(row[:employee_id].to_i)
    Order.new(row)
  end

  def undelivered_orders
    @elements.reject { |element| element.delivered? }
  end

  def mark_as_delivered(element)
    element.deliver!
    save_csv
  end

  def my_undelivered_orders(employee)
    @elements.select { |element| element.employee == employee && !element.delivered? }
  end
end
