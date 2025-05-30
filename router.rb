# rubocop:disable Metrics/ClassLength
class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      title
      @current_user = @sessions_controller.login
      @current_user.manager? ? display_options : display_rider_options while @current_user
      print `clear`
    end
    puts 'Bye!'
  end

  def display_rider_options
    puts ''.center(40, '-')
    puts "\nWhat do you want to do?"
    puts '1 - List my undelivered orders'
    puts '2 - Mark order as delivered'
    puts '9 - Logout'
    puts '0 - Exit'
    action = gets.chomp.to_i
    print `clear`
    dispatch_rider(action)
  end

  def display_options
    puts ''.center(40, '-')
    puts "\nWhat do you want to do?"
    ['1 - Access meals menu',
     '2 - Access customers menu',
     '3 - Access orders menu',
     '9 - Logout',
     '0 - Exit'].each { |opt| puts opt }
    action = gets.chomp.to_i
    print `clear`
    dispatch(action)
  end

  def display_meals_menu
    puts '1 - List all meals'
    puts '2 - Add a new meal'
    puts '3 - Edit a meal'
    puts '4 - Delete a meal'
    puts '0 - Exit'
    meal_action = gets.chomp.to_i
    dispatch_meals(meal_action)
  end

  def display_customer_menu
    puts '1 - List all customers'
    puts '2 - Add a new customer'
    puts '3 - Edit a customer'
    puts '4 - Delete a customer'
    puts '0 - Exit'
    customer_action = gets.chomp.to_i
    dispatch_customers(customer_action)
  end

  def display_order_menu
    puts '1 - List all orders'
    puts '2 - Add a new order'
    puts '3 - Edit an order'
    puts '4 - Delete an order'
    puts '0 - Exit'
    order_action = gets.chomp.to_i
    dispatch_orders(order_action)
  end

  def dispatch(action)
    title
    case action
    when 1 then display_meals_menu
    when 2 then display_customer_menu
    when 3 then display_order_menu
    when 9 then logout!
    when 0 then stop!
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_meals(action)
    title
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @meals_controller.edit
    when 4 then @meals_controller.remove
    when 0 then stop!
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_customers(action)
    title
    case action
    when 1 then @customers_controller.list
    when 2 then @customers_controller.add
    when 3 then @customers_controller.edit
    when 4 then @customers_controller.remove
    when 0 then stop!
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_orders(action)
    title
    case action
    when 1 then @orders_controller.list_undelivered_orders
    when 2 then @orders_controller.add
    when 3 then @orders_controller.edit
    when 4 then @orders_controller.remove
    when 0 then stop!
    else
      puts 'Invalid option!'
    end
  end

  def dispatch_rider(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 9 then logout!
    when 0 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
    @current_user = nil
  end

  def logout!
    @current_user = nil
  end

  def title
    print `clear`
    puts ''.center(40, '=')
    puts ' Food Delivery '.center(40, '=')
    puts ''.center(40, '=')
    puts ''
  end
end

# rubocop:enable Metrics/ClassLength
