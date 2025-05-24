class CustomersView
  def ask_user_for(info)
    puts "What's the customer's #{info}?"
    gets.chomp
  end

  def ask_user_for_id
    puts "Choose a customer:"
    print '> '
    gets.chomp.to_i
  end

  def display(customers)
    puts "No customers available" if customers.empty?

    customers.each do |customer|
      puts "ID: #{customer.id} - #{customer.name} (#{customer.address})"
    end
  end

  def edit(info, data)
    # permite personalização do comportamento do Readline antes da entrada ser recebida
    Readline.pre_input_hook = lambda {
      # converte o parâmetro data para string e o insere como texto padrão no prompt
      Readline.insert_text data.to_s
      # atualiza a exibição com o texto inserido
      Readline.redisplay
      # redefine o pre_input_hook como nil, para que o mesmo comportamento não se aplique no futuro
      Readline.pre_input_hook = nil
    }
    # solicita entrada do usuário, interpolando o parâmetro info e aguarda a entrada
    input = Readline.readline("#{info}: ", false)
    # processa a entrada com o método inspect e remove as aspas duplas
    input.inspect.gsub('"', '')
  end
end
