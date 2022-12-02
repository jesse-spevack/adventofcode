require 'pry'

module Part1
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
end

module Part2
  class Solution < Part1::Solution
    def call
      score = 0
      File.readlines(@path).each do |line|
        opponent_code, your_code = line.split(' ')
        match = Match.new(Throw.new(opponent_code), Intention.new(your_code))
        round_score = match.shape_points + match.outcome_points 
        puts round_score
        score += round_score
      end

      return score
    end
  end

  class Intention
    DICTIONARY = {
      "X" => :lose,
      "Y" => :draw,
      "Z" => :win,
    }

    def initialize(letter_code)
      @intent = DICTIONARY[letter_code]
    end

    def win?
      @intent == :win
    end

    def draw?
      @intent == :draw
    end
  end

  class Throw
    DICTIONARY = {
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
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
    SHAPE_POINTS = {
      rock: 1,
      paper: 2,
      scissors: 3,
    }

    WINNER = {
      rock: :paper,
      paper: :scissors,
      scissors: :rock,
    }

    LOSER = {
      rock: :scissors,
      paper: :rock,
      scissors: :paper,
    }

    def initialize(opponent_throw, your_intention)
      @opponent_throw = opponent_throw
      @your_intention = your_intention
    end

    def outcome_points
      if @your_intention.win?
        6
      elsif @your_intention.draw?
        3
      else
        0
      end
    end

    def shape_points
      if @your_intention.win?
        SHAPE_POINTS[WINNER[@opponent_throw.shape]]
      elsif @your_intention.draw?
        SHAPE_POINTS[@opponent_throw.shape]
      else
        SHAPE_POINTS[LOSER[@opponent_throw.shape]]
      end
    end
  end
end