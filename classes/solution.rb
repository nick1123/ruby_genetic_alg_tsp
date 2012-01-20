class Array
  def swap!(a,b)
    self[a], self[b] = self[b], self[a]
    self
  end
end

# A solution object contains a possible solution (array of cities) to the TSP
class Solution
  attr_reader :city_names
  attr_accessor :cycles

  def initialize(city_names, fully_connected_map)
    @city_names = city_names.clone
    @fully_connected_map = fully_connected_map
    @type = "Unknown"
    @cycles = 0
  end
  
  def randomize_cities
    @city_names = @city_names.shuffle    
    @type = "Random"
  end
  
  # Calculate the total distance for this solution
  def total_distance
    sum = 0
    previous_city = nil
    @city_names.each do |city|
      sum += @fully_connected_map.get_distance(previous_city, city) if previous_city
      previous_city = city
    end
    
    return sum
  end
  
  # Take the city_names and combine with a different array of city_names to form a hybrid/child version
  def crossover(city_names2)
    # Copy 2 cities at a time thereby preserving the edge between them
    city_names_new = []
    max_index = city_names.size - 1
    index = 0
    while index <= max_index - 1
      parent = (rand > 0.5 ? @city_names : city_names2)
      city_names_new << parent[index] << parent[index + 1]
      index += 1
    end
    
    # Remove dup cities
    city_names_new.uniq!
    
    # Make a list of missing cities
    missing_cities = []
    city_names.each do |city| 
      missing_cities << city unless city_names_new.include?(city)
    end
    
    city_names_new.concat(missing_cities)
    @city_names = city_names_new
    @type = "Hybrid"
  end
  
  
  # Swap the position of elements x & y in @city_names
  def mutate(x=nil, y=nil)
    x = rand(@city_names.size) if x.nil?
    while(y.nil? || y==x)
      y = rand(@city_names.size)
    end
    
    @city_names.swap!(x,y)
    @type = "Mutant"
  end
  
  def city_list_to_s
    @city_names.join("")
  end
  
  def id
    city_list_to_s
  end
  
  def to_s
    "Solution: #{city_list_to_s}  Distance: #{total_distance}  #{@type}  LifeSpan: #{cycles}"
  end
end