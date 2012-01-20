class FullyConnectedMap
  attr_reader :fully_connected_map
  MAX_DISTANCE = 100_000
  
  def initialize(city_names)
    @city_names = city_names
    generate_fully_connected_map
  end

  def generate_fully_connected_map
    @fully_connected_map = {}
    city_names_cloned = @city_names.clone
    while city_names_cloned.size > 0
      city1 = city_names_cloned.pop
      city_names_cloned.each do |city2|
        distance = generate_random_distance
        @fully_connected_map[city1] ||= {}
        @fully_connected_map[city2] ||= {}
        @fully_connected_map[city1][city2] = distance
        @fully_connected_map[city2][city1] = distance
      end
    end
  end
  
  def get_distance(city1, city2)
    @fully_connected_map[city1][city2]
  end

  def generate_random_distance
    (MAX_DISTANCE * rand).ceil
  end
end