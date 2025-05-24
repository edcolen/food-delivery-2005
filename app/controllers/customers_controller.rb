require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def add
    name = @customers_view.ask_user_for(:name)
    address = @customers_view.ask_user_for(:address)
    customer = Customer.new(name:, address:)
    @customer_repository.create(customer)
    list
  end

  def edit
    list
    id = @customers_view.ask_user_for_id
    customer = @customer_repository.find(id)
    customer.name = @customers_view.edit('name', customer.name)
    customer.address = @customers_view.edit('address', customer.address)
    @customer_repository.save_csv
    list
  end

  def remove
    list
    id = @customers_view.ask_user_for_id
    @customer_repository.destroy(id)
    list
  end

  def list
    customers = @customer_repository.all
    @customers_view.display(customers)
  end
end
