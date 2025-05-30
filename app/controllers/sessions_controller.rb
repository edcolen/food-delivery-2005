require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repo)
    @sessions_view = SessionsView.new
    @employee_repo = employee_repo
  end

  def login
    username = @sessions_view.ask_for(:username)
    password = @sessions_view.ask_for(:password)
    employee = @employee_repo.find_by_username(username)
    return employee if employee && employee.password == password

    @sessions_view.print_wrong_credentials
    login
  end
end
