require "minitest/autorun"
require "minitest/pride"
require "./day2/solution"

class TestSolution < Minitest::Test
  def test_that_it_solves_the_test_case
    expected = 15
    actual = Solution.new("./day2/test.txt").call
    assert_equal(expected, actual)
  end
end