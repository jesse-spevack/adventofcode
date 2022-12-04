require 'pry'
class Rucksack
  attr_reader :items, :count, :midpoint

  def initialize(items)
    @items = items
    @count = items.length
    @midpoint = (items.length - 1) / 2
  end

  def compartments
    [items[0..midpoint], items[(midpoint + 1)..(count - 1)]]
  end

  def duplicate
    a, b = compartments
    compartments_hash = Hash.new(0)
    a.chars.each do |char|
      compartments_hash[char] += 1
    end

    dupe = false
    b.chars.each do |char|
      next if dupe

      dupe = char if compartments_hash[char] != 0
    end
    dupe
  end

  def self.convert(item)
    (('a'..'z').to_a + ('A'..'Z').to_a).index(item) + 1
  end

  def self.call(path)
    total = 0
    File.readlines(path).each do |items|
      #   puts "total is: #{total}"
      duplicate = Rucksack.new(items.strip).duplicate
      raise 'No duplicate!' unless duplicate

      #   puts "duplicate is: #{duplicate}"
      #   puts "point value is: #{convert(duplicate)}"

      total += convert(duplicate)
    end

    total
  end
end

class Part2
  def initialize(path)
    @path = path
  end

  def divide
    groups_of_three = []
    File.readlines(@path).each_with_index do |raw_item, index|
      item = raw_item.chomp
      if (index % 3).zero?
        groups_of_three << [item]
      else
        groups_of_three.last << item
      end
    end

    groups_of_three
  end

  def common_item
    groups = divide
    items = []
    groups.each do |group|
      common_item_found = false
      group.first.chars.each do |char|
        next if common_item_found

        if group[1].include?(char) && group[2].include?(char)
          items << char
          common_item_found = true
        end
      end
    end

    items
  end

  def solution
    items = common_item
    items.sum { |item| Rucksack.convert(item) }
  end
end
