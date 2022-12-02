require 'pry'
path = './day1_input.txt'
test_path = './day1_test_input.txt'

def total_calories_of_top_three_elves(path)
  max_elf_calories = []
  current_elf_calories = 0
  line_count = `wc -l "#{path}"`.strip.split(' ')[0].to_i

  File.readlines(path).each_with_index do |line, index|
    last_line = index + 1 == line_count
    current_elf_calories += line.strip.to_i if last_line

    if line == "\n" || last_line
      if max_elf_calories.length < 3
        max_elf_calories << current_elf_calories
      else
        calories = [*max_elf_calories, current_elf_calories].sort!.reverse!
        calories.pop
        max_elf_calories = calories
      end

      current_elf_calories = 0
    else
      current_elf_calories += line.strip.to_i
    end
  end

  max_elf_calories.sum
end

puts total_calories_of_top_three_elves(path)
# puts 45_000
