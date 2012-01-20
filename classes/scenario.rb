# Scenario obj takes a city_count & solution_count param and should:
#   Generate a list of possible city names
#   Generate a fully connected map
#   Generate a list of solutions (each solution has a list of cities)
class Scenario
  attr_reader :city_count, :solution_count, :city_names
  
  def initialize(city_count, solution_count, divergence_min, iterations_min, iterations_max)
    @city_count = city_count
    @solution_count = solution_count
    @divergence_min = divergence_min
    @iterations_min = iterations_min
    @iterations_max = iterations_max
    @count_best_solutions = @solution_count / 4
    @iteration = 0
    generate_city_names
    generate_fully_connected_map
    generate_initial_solution_set
  end
  
  def generate_fully_connected_map
    @fully_connected_map = FullyConnectedMap.new(@city_names)    
  end
  
  def generate_city_names
    @city_names = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".split(//)[0..(@city_count - 1)]
  end
  
  def generate_initial_solution_set
    @solutions = {}
    (1..@solution_count).each do |i|
      solution = Solution.new(@city_names, @fully_connected_map)
      solution.randomize_cities
      @solutions[solution.id] = solution
    end
  end
  
  def find_best_solutions
    # Order solutions by total_distance 
    solutions_ordered = []
    @solutions.sort {|a,b| a[1].total_distance <=> b[1].total_distance}.each do |item|
      solution = item[1]
      solutions_ordered << solution
    end
    
    # Top 25% of solutions are best/most_fit
    @solutions_best = solutions_ordered[0..(@count_best_solutions - 1)]
    
    # Increment the cycles for best solutions
    @solutions_best.each {|solution| solution.cycles += 1}   
    
    a = @solutions_best[0].total_distance.to_f
    b = @solutions_best[-1].total_distance
    @divergence_measue = (b - a) / a
  end
  
  def create_mutants
    # Clone best solutions and mutate the clones
    @best_solutions_cloned_and_mutated = []
    @solutions_best.each do |solution|
      solution_clone = Solution.new(solution.city_names, @fully_connected_map)
      solution_clone.mutate
      @best_solutions_cloned_and_mutated << solution_clone
    end    
  end

  def create_offspring
    # Generate offspring solutions based on crossover between 2 of solutions_best
    @best_solutions_offspring = []
    count_offspring = @count_best_solutions
    @solutions_best.each do |solution1|
      solution2 = @solutions_best[rand(@count_best_solutions)]
      solution_offspring = Solution.new(solution1.city_names, @fully_connected_map)
      solution_offspring.crossover(solution2.city_names)
      @best_solutions_offspring << solution_offspring
    end    
  end
  
  def create_random_solutions
    @solutions_random = []
    (1..@count_best_solutions).each do |i|
      solution = Solution.new(@city_names, @fully_connected_map)
      solution.randomize_cities
      @solutions_random << solution
    end    
  end

  def run
    @divergence_measue = 1
    while (@divergence_measue > @divergence_min || @iteration < @iterations_min) && @iteration < @iterations_max
      @iteration += 1
      find_best_solutions
      create_mutants
      create_offspring
      create_random_solutions
      puts "Best Solutions (Top #{@count_best_solutions} out of population of #{@solution_count})"
      puts @solutions_best
      puts "Iteration: #{@iteration} (Min: #{@iterations_min})    Divergence: #{@divergence_measue} (Min: #{@divergence_min})"
      puts ""
    
      # Combine best, mutated, offspring, and random solutions
      @solutions = {}
      [@solutions_best, @best_solutions_cloned_and_mutated, @best_solutions_offspring, @solutions_random].each do |solutions_array|
        solutions_array.each do |solution|
          @solutions[solution.id] = solution if @solutions[solution.id].nil?
        end
      end    
    end
  end
  
  def to_s
    lines = []
    @solutions.each do |id, solution|
      lines << "#{id}\t#{solution.total_distance}"
    end
    
    lines.join("\n")
  end
  
end