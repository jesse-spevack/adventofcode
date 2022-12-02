require 'pry'
class Solution
  def initialize(path)
    @path = path
  end

  def call 
    score = 0
    File.readlines(@path).each do |line|
      opponent_throw, your_throw = line.split(' ').map { |letter_code| Throw.new(letter_code) }
      match = Match.new(opponent_throw, your_throw)
      round_score = match.points + your_throw.points
      score += round_score
    end

    return score
  end

end

class Throw
  DICTIONARY = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
  }

  SHAPE_POINTS = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }

  def initialize(letter_code)
    @letter_code = letter_code
  end

  def shape
    DICTIONARY[@letter_code]
  end

  def points
    SHAPE_POINTS[shape]    
  end
end

class Match
  def initialize(opponent_throw, your_throw)
    @opponent_throw = opponent_throw.shape
    @your_throw = your_throw.shape
  end

  def points
    return 6 if won?
    return 3 if tie?
    0
  end

  private

  def won?
    winner == :you
  end

  def tie?
    winner == false
  end

  def winner
    return false if @opponent_throw == @your_throw

    case @opponent_throw
    when :rock
      @your_throw == :paper ? :you : :opponent
    when :paper 
      @your_throw == :scissors ? :you : :opponent
    when :scissors 
      @your_throw == :rock ? :you : :opponent
    end
  end
end