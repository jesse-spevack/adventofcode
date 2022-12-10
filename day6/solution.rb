require 'pry'

module Part1Solution
  class Solver
    attr_reader :stream
    def initialize(stream)
      @stream = stream
    end

    def call
      last_four = []
      value = false

      stream.chars.each_with_index do |char, index|
        next if value

        if last_four.count < 4
          last_four << char
        elsif distinct?(last_four)
          value = index
        else
          last_four.shift
          last_four << char
        end
      end

      value
    end

    private

    def distinct?(message)
      map = message.each_with_object(Hash.new(0)) do |letter, acc|
        acc[letter] += 1
      end

      map.values.all? { |v| v == 1 }
    end
  end

  class Runner
    def self.call
      stream = File.readlines('./day6/input.txt').first
      Solver.new(stream).call
    end
  end
end

module Part2Solution
  class Solver
    attr_reader :stream
    def initialize(stream)
      @stream = stream
    end

    def call
      last_four = []
      value = false

      stream.chars.each_with_index do |char, index|
        next if value

        if last_four.count < 14
          last_four << char
        elsif distinct?(last_four)
          value = index
        else
          last_four.shift
          last_four << char
        end
      end

      value
    end

    private

    def distinct?(message)
      map = message.each_with_object(Hash.new(0)) do |letter, acc|
        acc[letter] += 1
      end

      map.values.all? { |v| v == 1 }
    end
  end

  class Runner
    def self.call
      stream = File.readlines('./day6/input.txt').first
      Solver.new(stream).call
    end
  end
end

puts "Solution: #{Part2Solution::Runner.call}"
