require 'rubygems'
require 'trollop'

Dir[File.dirname(__FILE__) + '/classes/*.rb'].each {|file| require file }

opts = Trollop::options do
  opt :divergence_min, "Level of divergence needed to stop", :type => :float, :default => 0.01
  opt :cities_count, "How many cities are we solving for? (5 - 62)", :type => :int, :default => 62
  opt :solutions_count, "How many solutions are in a population? Must be an integer >= 8 && divisible by 4", :type => :int, :default => 40
  opt :iterations_min, "How many iterations before we can possibly stop (if divergence is low enough)", :type => :int, :default => 1_000
  opt :iterations_max, "After this many iterations we stop looking for better solutions", :type => :int, :default => 5_000
end

Trollop::die :cities_count, "must be >= 5"  if opts[:cities_count] < 5
Trollop::die :cities_count, "must be <= 62" if opts[:cities_count] > 62
Trollop::die :solutions_count, "must be >= 8" if opts[:solutions_count] < 8
Trollop::die :solutions_count, "must be divisible by 4" if (opts[:solutions_count] % 4) != 0

scenario = Scenario.new(opts[:cities_count], opts[:solutions_count], opts[:divergence_min], opts[:iterations_min], opts[:iterations_max])
scenario.run
