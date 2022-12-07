require 'minitest/autorun'
require 'minitest/pride'
require './day5/solution.rb'

class Part1SolutionTest < Minitest::Test
  #     [D]
  # [N] [C]
  # [Z] [M] [P]
  #  1   2   3

  # move 1 from 2 to 1
  # move 3 from 1 to 3
  # move 2 from 2 to 1
  # move 1 from 1 to 2

  def test_parse_row
    path = './day5/test_input.txt'
    lines = File.readlines(path)
    solution3 = Part1Solution::Row.new(lines[2]).parse
    solution2 = Part1Solution::Row.new(lines[1]).parse
    solution1 = Part1Solution::Row.new(lines[0]).parse

    assert_equal(%w[Z M P], solution3)
    assert_equal(['N', 'C', nil], solution2)
    assert_equal([nil, 'D', nil], solution1)
  end

  def test_parse_arrangement
    path = './day5/test_input.txt'
    lines = File.readlines(path)[0..2]
    solution = Part1Solution::Arrangement.new(lines).call
    expected = [
      [nil, 'D', nil],
      ['N', 'C', nil],
      %w[Z M P]
    ]

    assert_equal(expected, solution)
  end

  def test_assemble_arrangment_map
    path = './day5/test_input.txt'
    lines = File.readlines(path)[0..3]
    solution = Part1Solution::ArrangementMap.new(lines).call
    expected = {
      1 => %w[Z N],
      2 => %w[M C D],
      3 => ['P']
    }

    assert_equal(expected, solution)
  end

  def test_get_move
    path = './day5/test_input.txt'
    lines = File.readlines(path)

    solution1 = Part1Solution::Move.new(lines[5]).parse
    solution2 = Part1Solution::Move.new(lines[6]).parse
    solution3 = Part1Solution::Move.new(lines[7]).parse
    solution4 = Part1Solution::Move.new(lines[8]).parse

    assert_equal([1, 2, 1], solution1)
    assert_equal([3, 1, 3], solution2)
    assert_equal([2, 2, 1], solution3)
    assert_equal([1, 1, 2], solution4)
  end

  def test_get_moves
    path = './day5/test_input.txt'
    lines = File.readlines(path)[5..8]

    solution = Part1Solution::Moves.new(lines).parse

    expected = [[1, 2, 1],
                [3, 1, 3],
                [2, 2, 1],
                [1, 1, 2]]

    assert_equal(expected, solution)
  end

  def test_split_input
    path = './day5/test_input.txt'
    splitter = Part1Solution::Splitter.new(path)
    solution1 = splitter.moves
    solution2 = splitter.arrangement_map

    expected1 = [[1, 2, 1],
                 [3, 1, 3],
                 [2, 2, 1],
                 [1, 1, 2]]

    expected2 = {
      1 => %w[Z N],
      2 => %w[M C D],
      3 => ['P']
    }

    assert_equal(expected1, solution1)
    assert_equal(expected2, solution2)
  end

  def test_mover1
    move = [1, 2, 1]
    arrangement_map = {
      1 => %w[Z N],
      2 => %w[M C D],
      3 => ['P']
    }

    solution = Part1Solution::Mover.new(move, arrangement_map).call

    expected = {
      1 => %w[Z N D],
      2 => %w[M C],
      3 => ['P']
    }

    assert_equal(expected, solution)
  end

  def test_mover2
    move = [3, 1, 3]
    arrangement_map = {
      1 => %w[Z N D],
      2 => %w[M C],
      3 => ['P']
    }

    solution = Part1Solution::Mover.new(move, arrangement_map).call

    expected = {
      1 => [],
      2 => %w[M C],
      3 => %w[P D N Z]
    }

    assert_equal(expected, solution)
  end

  def test_mover3
    move = [2, 2, 1]
    arrangement_map = {
      1 => [],
      2 => %w[M C],
      3 => %w[P D N Z]
    }

    solution = Part1Solution::Mover.new(move, arrangement_map).call

    expected = {
      1 => %w[C M],
      2 => [],
      3 => %w[P D N Z]
    }

    assert_equal(expected, solution)
  end

  def test_mover4
    move = [1, 1, 2]
    arrangement_map = {
      1 => %w[C M],
      2 => [],
      3 => %w[P D N Z]
    }

    solution = Part1Solution::Mover.new(move, arrangement_map).call

    expected = {
      1 => ['C'],
      2 => %w[M],
      3 => %w[P D N Z]
    }

    assert_equal(expected, solution)
  end

  def test_inspector
    arrangement_map = {
      1 => ['C'],
      2 => %w[M],
      3 => %w[P D N Z]
    }

    solution = Part1Solution::Inspector.new(arrangement_map).call

    assert_equal('CMZ', solution)
  end

  def test_solver
    path = './day5/test_input.txt'
    solution = Part1Solution::Solver.new(path).call
    assert_equal('CMZ', solution)
  end
end

class Part2SolutionTest < Minitest::Test
  def test_solver
    path = './day5/test_input.txt'
    solution = Part2Solution::Solver.new(path).call
    assert_equal('MCD', solution)
  end
end
