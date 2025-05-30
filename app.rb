require_relative "app/repositories/meal_repository"
require_relative "app/controllers/meals_controller"

require_relative "app/repositories/customer_repository"
require_relative "app/controllers/customers_controller"

require_relative "app/repositories/order_repository"
require_relative "app/controllers/orders_controller"

require_relative "app/repositories/employee_repository"
require_relative "app/controllers/sessions_controller"

require_relative "router"

meal_csv = File.join(__dir__, '/data/meals.csv')
meal_repo = MealRepository.new(meal_csv)
meals_controller = MealsController.new(meal_repo)

customer_csv = File.join(__dir__, '/data/customers.csv')
customer_repo = CustomerRepository.new(customer_csv)
customers_controller = CustomersController.new(customer_repo)

employee_csv = File.join(__dir__, '/data/employees.csv')
employee_repo = EmployeeRepository.new(employee_csv)
sessions_controller = SessionsController.new(employee_repo)

order_csv = File.join(__dir__, '/data/orders.csv')
order_repo = OrderRepository.new(order_csv, meal_repo, customer_repo, employee_repo)
orders_controller = OrdersController.new(meal_repo, customer_repo, employee_repo, order_repo)


router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)
router.run
