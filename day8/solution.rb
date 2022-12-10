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
      grid = []
      File.readlines(path).each do |line|
        trees = line.chomp.chars
        grid << trees
      end

      height = grid.count
      width = grid.first.count

      max_score = 0
      all = []

      grid.each_with_index do |row, i|
        row.each_with_index do |t, j|
          tree = t.to_i
          score = { tree: t.to_i, up: 0, left: 0, right: 0, down: 0, i: i, j: j }
          column = grid.map { |r| r[j] }

          # up
          (0...i).to_a.reverse.each do |k|
            neighbor = column[k].to_i
            score[:up] += 1

            break if neighbor >= tree.to_i
          end

          # left
          (0...j).to_a.reverse.each do |k|
            neighbor = row[k].to_i
            score[:left] += 1

            break if neighbor >= tree.to_i
          end

          # right
          ((j + 1)...width).to_a.each do |k|
            neighbor = row[k].to_i
            score[:right] += 1

            break if neighbor >= tree.to_i
          end

          # down
          ((i + 1)...height).to_a.each do |k|
            neighbor = column[k].to_i
            score[:down] += 1

            break if neighbor >= tree.to_i
          end

          total_score = score[:up] * score[:down] * score[:left] * score[:right]
          score[:total_score] = total_score
          all << score
          max_score = total_score if total_score > max_score
        end
      end

      max_score
    end
  end
end
