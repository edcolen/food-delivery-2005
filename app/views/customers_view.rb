class CustomersView
  def ask_user_for(info)
    puts "What's the customer's #{info}?"
    gets.chomp
  end

  def ask_user_for_index
    puts "Choose a customer:"
    print '> '
    gets.chomp.to_i - 1
  end

  def display(customers)
    puts "No customers available" if customers.empty?

    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end
  end

  def edit(info, data)
    # allows customization of Readline behavior before input is taken
    Readline.pre_input_hook = lambda {
      # converts the data parameter to a string and inserts it as the default input text in the prompt
      Readline.insert_text data.to_s
      # updates the display with the inserted text
      Readline.redisplay
      # resets the pre_input_hook to nil, so the same behavior won't apply in the future
      Readline.pre_input_hook = nil
    }
    # prompts the user, interpolating the info parameter and waits for user input
    input = Readline.readline("#{info}: ", false)
    # processes the input with the inspect method, than cleans it to remove double quotes
    input.inspect.gsub('"', '')
  end
end
