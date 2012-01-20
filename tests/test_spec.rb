Dir[File.dirname(__FILE__) + '/../classes/*.rb'].each {|file| require file }

CITY_COUNT = 17
SOLUTION_COUNT = 12
CITY_NAMES = ["A", "B", "C", "D"]

DIVERGENCE_MIN = 0.1
ITERATIONS_MIN = 100
ITERATIONS_MAX = 5_000


FULLY_CONNECTED_MAP = FullyConnectedMap.new(CITY_NAMES)    


describe Scenario, "initialize" do
  scenario = Scenario.new(CITY_COUNT, SOLUTION_COUNT, DIVERGENCE_MIN, ITERATIONS_MIN, ITERATIONS_MAX)
  
  it "creates the correct number of cities" do
    scenario.city_count.should eq(CITY_COUNT)
  end

  it "returns the correct number of solutions" do
    scenario.solution_count.should eq(SOLUTION_COUNT)
  end
end

describe Scenario, "generate_city_names" do  
  it "creates the correct subset of cities" do
    scenario = Scenario.new(6, SOLUTION_COUNT, DIVERGENCE_MIN, ITERATIONS_MIN, ITERATIONS_MAX)
    scenario.city_names.should eq(["A", "B", "C", "D", "E", "F"])
  end  
end

describe FullyConnectedMap, "generate_fully_connected_map" do  
  fcm = FullyConnectedMap.new(CITY_NAMES)
  hsh = fcm.fully_connected_map

  it "should not have a city connect to itself" do
    CITY_NAMES.each do |city1|
      hsh[city1][city1].should be_nil
    end
  end

  it "should have a city connect to every other with a value > 0" do
    CITY_NAMES.each do |city1|
      CITY_NAMES.each do |city2|
        next if city1 == city2
        hsh[city1][city2].should eql(hsh[city2][city1])
        hsh[city1][city2].should be > 0
      end
    end
  end

end

describe Solution, "mutate" do
  it "switches the order of 2 cities" do
    solution = Solution.new(["A", "B", "C", "D", "E"], FULLY_CONNECTED_MAP)
    solution.city_names.should eql(["A", "B", "C", "D", "E"])
    solution.mutate(1,2)
    solution.city_names.should eql(["A", "C", "B", "D", "E"])
    solution.mutate(4,2)
    solution.city_names.should eql(["A", "C", "E", "D", "B"])
  end
end
