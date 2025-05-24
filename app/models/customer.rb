class Customer
  attr_accessor :id, :name, :address

  def initialize(att = {})
    @id = att[:id]
    @name = att[:name]
    @address = att[:address]
  end

  def to_csv_row
    [@id, @name, @address]
  end

  def self.headers
    %w[id name address]
  end
end
