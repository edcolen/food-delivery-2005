require 'io/console'

class SessionsView
  def ask_for(info)
    puts "Type your #{info}"
    print "> "
    info == :password ? $stdin.noecho(&:gets).chomp : gets.chomp
  end

  def print_wrong_credentials
    puts "Wrong credentials... Try again"
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end
end
