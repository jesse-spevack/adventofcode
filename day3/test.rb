require 'minitest/autorun'
require 'minitest/pride'
require './solution.rb'

class SolutionTest < Minitest::Test
  def test_compartments
    rucksack = Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp')
    expected_compartments = %w[vJrwpWtwJgWr hcsFMMfFFhFp]

    actual = rucksack.compartments
    assert_equal(expected_compartments, actual)

    rucksack = Rucksack.new('jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL')
    expected_compartments = %w[jqHRNqRjqzjGDLGL rsFMfFZSrLrFZsSL]

    actual = rucksack.compartments
    assert_equal(expected_compartments, actual)

    rucksack = Rucksack.new('PmmdzqPrVvPwwTWBwg')
    expected_compartments = %w[PmmdzqPrV vPwwTWBwg]

    actual = rucksack.compartments
    assert_equal(expected_compartments, actual)
  end

  def test_duplicate
    rucksack = Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp')
    expected_duplicate = 'p'

    actual = rucksack.duplicate
    assert_equal(expected_duplicate, actual)

    rucksack = Rucksack.new('jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL')
    expected_duplicate = 'L'

    actual = rucksack.duplicate
    assert_equal(expected_duplicate, actual)

    rucksack = Rucksack.new('PmmdzqPrVvPwwTWBwg')
    expected_duplicate = 'P'

    actual = rucksack.duplicate
    assert_equal(expected_duplicate, actual)

    rucksack = Rucksack.new('wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn')
    expected_duplicate = 'v'

    actual = rucksack.duplicate
    assert_equal(expected_duplicate, actual)

    rucksack = Rucksack.new('ttgJtRGJQctTZtZT')
    expected_duplicate = 't'

    actual = rucksack.duplicate
    assert_equal(expected_duplicate, actual)

    rucksack = Rucksack.new('CrZsJsPPZsGzwwsLwLmpwMDw')
    expected_duplicate = 's'

    actual = rucksack.duplicate
    assert_equal(expected_duplicate, actual)
  end

  def test_convert
    letters = ('a'..'z').to_a
    letters.each do |letter|
      assert_equal(letters.index(letter) + 1, Rucksack.convert(letter))
    end

    letters = ('A'..'Z').to_a
    letters.each do |letter|
      assert_equal(letters.index(letter) + 27, Rucksack.convert(letter))
    end

    assert_equal(16, Rucksack.convert('p'))
    assert_equal(38, Rucksack.convert('L'))
    assert_equal(42, Rucksack.convert('P'))
    assert_equal(22, Rucksack.convert('v'))
    assert_equal(20, Rucksack.convert('t'))
    assert_equal(19, Rucksack.convert('s'))
  end

  def test_call
    path = './test_input.txt'
    solution = Rucksack.call(path)
    assert_equal(157, solution)
  end

  def test_groups_of_three
    path = './test_input.txt'

    solution = Part2.new(path).divide

    expected = [
      %w[vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg],
      %w[wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn ttgJtRGJQctTZtZT CrZsJsPPZsGzwwsLwLmpwMDw]
    ]

    assert_equal(expected, solution)
  end

  def test_get_common_letter
    path = './test_input.txt'

    solution = Part2.new(path).common_item

    expected = %w[r Z]

    assert_equal(expected, solution)
  end

  def test_solution
    path = './test_input.txt'

    solution = Part2.new(path).solution

    expected = 70

    assert_equal(expected, solution)
  end
end
