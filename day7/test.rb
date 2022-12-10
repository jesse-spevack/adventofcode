require 'minitest/autorun'
require 'minitest/pride'
require './day7/solution.rb'

class Part1SolutionTest < Minitest::Test
  def test_solver
    path = './day7/test_input.txt'
    solution = Part1Solution::Solver.new(path).call
    assert_equal(95_437, solution)
  end
end

class Part2SolutionTest < Minitest::Test
  def test_solver
    path = './day7/test_input.txt'
    solution = Part2Solution::Solver.new(path).call
    assert_equal(24_933_642, solution)
  end
end
