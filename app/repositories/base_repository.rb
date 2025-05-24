require "csv"

class BaseRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def all
    @elements
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  def destroy(id)
    @elements = @elements.reject { |element| element.id == id }
    save_csv
  end

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      break unless @elements.first

      csv << @elements.first.class.headers
      @elements.each do |element|
        csv << element.to_csv_row
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      @elements << build_element(row)
    end
    @next_id = @elements.last.id + 1 unless @elements.empty?
  end
end
