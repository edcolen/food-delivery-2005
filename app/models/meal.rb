class Meal
  attr_accessor :id, :name, :price

  def initialize(att = {})
    @id = att[:id]
    @name = att[:name]
    @price = att[:price]
  end

  def to_csv_row
    [@id, @name, @price]
  end

  def self.headers
    %w[id name price]
  end
end
