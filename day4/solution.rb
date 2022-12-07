require 'pry'

class Part1Solution
  attr_reader :a, :b
  def initialize(a, b)
    @a = Range.new(*a.split('-').map(&:to_i))
    @b = Range.new(*b.split('-').map(&:to_i))
  end

  def overlapping?
    a.to_a.all? { |i| b.include?(i) } || b.to_a.all? { |i| a.include?(i) }
  end

  def self.overlapping_count(path)
    count = 0
    File.readlines(path).each do |line|
      count += new(*line.chomp.split(',')).overlapping? ? 1 : 0
    end

    count
  end
end

class Part2Solution
  attr_reader :a, :b
  def initialize(a, b)
    @a = Range.new(*a.split('-').map(&:to_i))
    @b = Range.new(*b.split('-').map(&:to_i))
  end

  def overlapping?
    a.to_a.any? { |i| b.include?(i) } || b.to_a.any? { |i| a.include?(i) }
  end

  def self.overlapping_count(path)
    count = 0
    File.readlines(path).each do |line|
      count += new(*line.chomp.split(',')).overlapping? ? 1 : 0
    end

    count
  end
end
