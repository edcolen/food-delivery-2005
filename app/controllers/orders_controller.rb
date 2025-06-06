require_relative "../views/meals_view"
require_relative "../views/customers_view"
require_relative "../views/sessions_view"
require_relative "../views/orders_view"

class OrdersController
  def initialize(meal_repo, customer_repo, employee_repo, order_repo)
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @order_repo = order_repo
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @sessions_view = SessionsView.new
    @orders_view = OrdersView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repo.create(order)
    list_undelivered_orders
  end

  def edit
    order = select_order
    @orders_view.show_object(:meal, order.meal&.name)
    order.meal = select_meal
    @orders_view.show_object(:customer, order.customer&.name)
    order.customer = select_customer
    @orders_view.show_object(:employee, order.employee&.username)
    order.employee = select_employee
    @order_repo.save_csv
    list_undelivered_orders
  end

  def remove
    order = select_order
    @order_repo.destroy(order.id)
    list_undelivered_orders
  end

  def list_undelivered_orders
    undelivered_orders = @order_repo.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_my_orders(current_user)
    list_my_undelivered_orders(current_user)
  end

  def mark_as_delivered(current_user)
    list_my_undelivered_orders(current_user)
    index = @orders_view.ask_user_for_index
    my_orders = @order_repo.my_undelivered_orders(current_user)
    order = my_orders[index]
    @order_repo.mark_as_delivered(order)
  end

  private

  def select_meal
    meals = @meal_repo.all
    @meals_view.display(meals)
    index = @orders_view.ask_user_for_index
    return meals[index]
  end

  def select_customer
    customers = @customer_repo.all
    @customers_view.display(customers)
    index = @orders_view.ask_user_for_index
    return customers[index]
  end

  def select_employee
    employees = @employee_repo.all_riders
    @sessions_view.display(employees)
    index = @orders_view.ask_user_for_index
    return employees[index]
  end

  def select_order
    orders = @order_repo.undelivered_orders
    list_undelivered_orders
    index = @orders_view.ask_user_for_index
    return orders[index]
  end

  def list_my_undelivered_orders(user)
    orders = @order_repo.my_undelivered_orders(user)
    @orders_view.display(orders)
  end
end
