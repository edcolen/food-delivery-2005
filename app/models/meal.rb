class Meal
  attr_accessor :id, :name, :price

  def initialize(attr = {})
    @id = attr[:id]
    @name = attr[:name]
    @price = attr[:price]
  end

  def to_csv_row
    [@id, @name, @price]
  end

  def self.headers
    %w[id name price]
  end
end
