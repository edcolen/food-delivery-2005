class Order
  attr_accessor :id, :employee, :meal, :customer, :delivered

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def to_csv_row
    [@id, delivered?, @meal.id, @customer.id, @employee.id]
  end

  def self.headers
    %w[id delivered meal_id customer_id employee_id]
  end
end
