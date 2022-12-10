require 'minitest/autorun'
require 'minitest/pride'
require './day6/solution.rb'

class Part1SolutionTest < Minitest::Test
  def test_solver_1
    stream = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
    expected = 7

    solution = Part1Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_2
    stream = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
    expected = 7

    solution = Part1Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_3
    stream = 'nppdvjthqldpwncqszvftbrmjlhg'
    expected = 6

    solution = Part1Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_4
    stream = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'
    expected = 10

    solution = Part1Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_5
    stream = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'
    expected = 11

    solution = Part1Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end
end

class Part2SolutionTest < Minitest::Test
  def test_solver_1
    stream = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
    expected = 19

    solution = Part2Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_2
    stream = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
    expected = 23

    solution = Part2Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_3
    stream = 'nppdvjthqldpwncqszvftbrmjlhg'
    expected = 23

    solution = Part2Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_4
    stream = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'
    expected = 29

    solution = Part2Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end

  def test_solver_5
    stream = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'
    expected = 26

    solution = Part2Solution::Solver.new(stream).call
    assert_equal(expected, solution)
  end
end
