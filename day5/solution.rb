require 'pry'

module Part1Solution
  class Row
    attr_reader :raw_row
    def initialize(raw_row)
      @raw_row = raw_row
    end

    def parse
      row = []
      raw_row.chomp.chars.each_slice(4) do |slice|
        row << slice.filter { |char| ('A'..'Z').to_a.include?(char) }.join
      end

      row.map { |c| c == '' ? nil : c }
    end
  end

  class Arrangement
    attr_reader :lines
    def initialize(lines)
      @lines = lines
    end

    def call
      lines.map { |raw_row| Row.new(raw_row).parse }
    end
  end

  class ArrangementMap
    attr_reader :keys, :arrangement
    def initialize(lines)
      @keys = lines.last.chomp.chars.map { |c| c == ' ' ? nil : c.to_i }.compact
      last_line = lines.count - 2
      @arrangement = Arrangement.new(lines[0..last_line]).call
    end

    def call
      keys.map do |key|
        [key, arrangement.reverse.map { |row| row[key - 1] }.compact]
      end.to_h
    end
  end

  class Move
    attr_reader :raw_move
    def initialize(raw_move)
      @raw_move = raw_move
    end

    def parse
      raw_move.chomp.split.map(&:to_i).filter { |i| !i.zero? }
    end
  end

  class Moves
    attr_reader :raw_moves
    def initialize(raw_moves)
      @raw_moves = raw_moves
    end

    def parse
      raw_moves.map { |raw_move| Move.new(raw_move).parse }
    end
  end

  class Splitter
    attr_reader :moves, :arrangement_map
    def initialize(path)
      raw_moves = []
      raw_lines = []
      break_found = false
      File.readlines(path).each do |line|
        if break_found
          raw_moves << line
        elsif line == "\n"
          break_found = true
        else
          raw_lines << line
        end
      end

      @moves = Moves.new(raw_moves).parse
      @arrangement_map = ArrangementMap.new(raw_lines).call
    end
  end

  class Mover
    attr_reader :move, :arrangement_map
    def initialize(move, arrangement_map)
      @move = move
      @arrangement_map = arrangement_map.dup
    end

    def call
      count = move[0]
      source = move[1]
      destination = move[2]

      count.times do
        letter = arrangement_map[source].pop
        arrangement_map[destination] << letter
      end

      arrangement_map
    end
  end

  class Inspector
    attr_reader :arrangement_map
    def initialize(arrangement_map)
      @arrangement_map = arrangement_map.dup
    end

    def call
      arrangement_map.values.map { |stack| stack.pop }.join
    end
  end

  class Solver
    def initialize(path)
      @path = path
    end

    def call
      splitter = Splitter.new(@path)
      moves = splitter.moves
      arrangement_map = splitter.arrangement_map

      final_arrangmenet = moves.reduce(arrangement_map) do |accum, move|
        Mover.new(move, accum).call
      end

      Inspector.new(final_arrangmenet).call
    end
  end
end

module Part2Solution
  class Solver
    def initialize(path)
      @path = path
    end

    def call
      splitter = Part1Solution::Splitter.new(@path)
      moves = splitter.moves
      arrangement_map = splitter.arrangement_map

      final_arrangmenet = moves.reduce(arrangement_map) do |accum, move|
        Mover.new(move, accum).call
      end

      Part1Solution::Inspector.new(final_arrangmenet).call
    end
  end

  class Mover
    attr_reader :move, :arrangement_map
    def initialize(move, arrangement_map)
      @move = move
      @arrangement_map = arrangement_map.dup
    end

    def call
      count = move[0]
      source = move[1]
      destination = move[2]

      letters = arrangement_map[source].pop(count)
      letters.each do |letter|
        arrangement_map[destination].push(letter)
      end

      arrangement_map
    end
  end
end
