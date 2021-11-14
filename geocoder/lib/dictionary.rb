require 'csv'

module Dictionary
  DATA_PATH = 'db/data/city.csv'

  def load_data!
    CSV.read(DATA_PATH, headers: true).inject({}) do |result, row|
      city = row['city']
      lat = row['geo_lat'].to_f
      lon = row['geo_lon'].to_f
      result[city] = [lat, lon]
      result
    end
  end
end
