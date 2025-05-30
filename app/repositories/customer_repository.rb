require_relative '../models/customer'
require_relative "../repositories/base_repository"

class CustomerRepository < BaseRepository
  def build_element(row)
    row[:id] = row[:id].to_i
    Customer.new(row)
  end
end
