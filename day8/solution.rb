require 'pry'

module Part1Solution
  class Solver
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def call
      grid = []
      File.readlines(path).each do |line|
        trees = line.chomp.chars
        grid << trees
      end

      height = grid.count
      width = grid.first.count

      count = 0

      grid.each_with_index do |row, i|
        first_or_last_row = i == 0 || i == height - 1
        row.each_with_index do |tree, j|
          tallest = false
          first_or_last_column = j == 0 || j == width - 1
          if first_or_last_row || first_or_last_column
            tallest = true
          else
            tallest_left = (0...j).to_a.all? { |l| row[l].to_i < tree.to_i }
            tallest_right = ((j + 1)...width).to_a.all? { |l| row[l].to_i < tree.to_i }

            column = grid.map { |row| row[j] }

            tallest_up = (0...i).to_a.all? { |l| column[l].to_i < tree.to_i }
            tallest_down = ((i + 1)...height).to_a.all? { |l| column[l].to_i < tree.to_i }

            tallest = tallest_left || tallest_right || tallest_up || tallest_down
          end

          count += 1 if tallest
        end
      end

      count
    end
  end
end

module Part2Solution
  class Solver
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def call
      true
    end
  end
end
