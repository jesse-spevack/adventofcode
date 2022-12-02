require "minitest/autorun"
require "minitest/pride"
require "./day2/solution"

class TestSolution < Minitest::Test
  def test_that_it_solves_the_test_case
    expected = 15
    actual = Part1::Solution.new("./day2/test.txt").call
    assert_equal(expected, actual)
  end

  def test_that_it_solves_the_part_2_test_case
    expected = 12
    actual = Part2::Solution.new("./day2/test.txt").call
    assert_equal(expected, actual)
  end
end