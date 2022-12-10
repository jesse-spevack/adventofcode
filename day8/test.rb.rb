require 'minitest/autorun'
require 'minitest/pride'
require './day8/solution.rb'

class Part1SolutionTest < Minitest::Test
  def test_solver
    path = './day8/test_input.txt'
    solution = Part1Solution::Solver.new(path).call
    assert_equal(21, solution)
  end
end

class Part2SolutionTest < Minitest::Test
  def test_solver
    path = './day8/test_input.txt'
    solution = Part2Solution::Solver.new(path).call
    assert_equal(8, solution)
  end
end
