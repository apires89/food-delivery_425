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

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      #insert headers into csv
      csv << headers
      @elements.each do |element|
        #insert elements into csv
        csv << save_row(element)
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      #access the rows in order to extract from csv
      row[:id] = row[:id].to_i
      load_row(row)
      #create an instance of the element
    end
    @next_id = @elements.last.id + 1 unless @elements.empty?
  end
end
