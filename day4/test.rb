require 'minitest/autorun'
require 'minitest/pride'
require './day4/solution.rb'

class Part1SolutionTest < Minitest::Test
  def test_overalapping
    a = '2-4'
    b = '6-8'
    solution = Part1Solution.new(a, b).overlapping?
    assert_equal(false, solution)

    a = '2-3'
    b = '4-5'
    solution = Part1Solution.new(a, b).overlapping?
    assert_equal(false, solution)

    a = '5-7'
    b = '7-9'
    solution = Part1Solution.new(a, b).overlapping?
    assert_equal(false, solution)

    a = '2-8'
    b = '3-7'
    solution = Part1Solution.new(a, b).overlapping?
    assert_equal(true, solution)

    a = '6-6'
    b = '4-6'
    solution = Part1Solution.new(a, b).overlapping?
    assert_equal(true, solution)

    a = '2-6'
    b = '4-8'
    solution = Part1Solution.new(a, b).overlapping?
    assert_equal(false, solution)
  end

  def test_overlapping_count
    solution = Part1Solution.overlapping_count('./day4/test_input.txt')
    assert_equal(2, solution)
  end
end

class Part2SolutionTest < Minitest::Test
  def test_overalapping
    a = '2-4'
    b = '6-8'
    solution = Part2Solution.new(a, b).overlapping?
    assert_equal(false, solution)

    a = '2-3'
    b = '4-5'
    solution = Part2Solution.new(a, b).overlapping?
    assert_equal(false, solution)

    a = '5-7'
    b = '7-9'
    solution = Part2Solution.new(a, b).overlapping?
    assert_equal(true, solution)

    a = '2-8'
    b = '3-7'
    solution = Part2Solution.new(a, b).overlapping?
    assert_equal(true, solution)

    a = '6-6'
    b = '4-6'
    solution = Part2Solution.new(a, b).overlapping?
    assert_equal(true, solution)

    a = '2-6'
    b = '4-8'
    solution = Part2Solution.new(a, b).overlapping?
    assert_equal(true, solution)
  end

  def test_overlapping_count
    solution = Part2Solution.overlapping_count('./day4/test_input.txt')
    assert_equal(4, solution)
  end
end
