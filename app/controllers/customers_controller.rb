require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repo)
    @customer_repo = customer_repo
    @customers_view = CustomersView.new
  end

  def add
    name = @customers_view.ask_user_for(:name)
    address = @customers_view.ask_user_for(:address)
    customer = Customer.new(name:, address:)
    @customer_repo.create(customer)
    list
  end

  def edit
    customer = select_customer
    customer.name = @customers_view.edit('name', customer.name)
    customer.address = @customers_view.edit('address', customer.address)
    @customer_repo.save_csv
    list
  end

  def remove
    customer = select_customer
    @customer_repo.destroy(customer.id)
    list
  end

  def list
    customers = @customer_repo.all
    @customers_view.display(customers)
  end

  def select_customer
    meals = @customer_repo.all
    @customers_view.display(meals)
    index = @customers_view.ask_user_for_index
    return meals[index]
  end
end
