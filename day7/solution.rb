require 'pry'

module Part1Solution
  class Solver
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def call
      file_structure = Terminal.new(path).call
      small_directories = file_structure.small_directories
      small_directories.sum(&:size)
    end
  end

  class Input
    attr_reader :command, :name

    ROOT = '/'.freeze
    OUT = '..'.freeze

    def initialize(line)
      args = line.split
      raise 'Invalid input' if args.first != '$'

      command = args[1]
      @name = args[2]
      @change_directory = command == 'cd'
    end

    def change_directory_in?
      @change_directory && ![ROOT, OUT].include?(name)
    end

    def change_directory_out?
      @change_directory && name == OUT
    end

    def change_directory_root?
      @change_directory && name == ROOT
    end
  end

  class Output
    attr_reader :args

    DIR = 'dir'.freeze

    def initialize(line)
      @args = line.split
    end

    def file_name
      args.last
    end

    def directory_name
      args.last
    end

    def file_size
      args.first
    end

    def dir?
      args.first == DIR
    end
  end

  class Terminal
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def call
      current_directory = nil

      File.readlines(path).each do |line|
        if line.chars.first == '$'
          input = Input.new(line.chomp)
          if current_directory.nil?
            current_directory = Directory.new(input.name, nil)
          elsif input.change_directory_in?
            current_directory = current_directory.child_directory(input.name)
          elsif input.change_directory_out?
            current_directory = current_directory.parent_directory
          elsif input.change_directory_root?
            current_directory = current_directory.root_directory
          end
          # do we need to handle LS?
        else
          output = Output.new(line.chomp)
          if output.dir?
            # should also increment directory size attribute
            current_directory.add_directory(output.directory_name)
          else
            # should also increment directory size attribute
            current_directory.add_file(output.file_name, output.file_size)
          end
        end
      end

      current_directory.root_directory
    end
  end

  class Directory
    attr_reader :name, :size, :parent, :children, :files
    def initialize(name, parent)
      @name = name
      @children = []
      @parent = parent
      @files = Hash.new(0)
    end

    def size
      files.values.map(&:to_i).sum + children.sum(&:size)
    end

    def parent_directory
      @parent
    end

    def add_directory(name)
      @children << Directory.new(name, self)
    end

    def add_file(name, size)
      @files[name] = size
    end

    def root_directory
      return self if root?

      parent.root_directory
    end

    def root?
      name == '/'
    end

    def child_directory(name)
      @children.find { |child| child.name == name }
    end

    def small?
      size <= 100_000
    end

    def small_directories
      small_children = children.filter(&:small?)

      children.each do |child|
        small_children.concat(child.small_directories)
      end

      small_children
    end

    NameSize = Struct.new(:name, :size)

    def name_size
      [NameSize.new(name, size)] + children.map(&:name_size)
    end
  end
end

module Part2Solution
  class Solver
    attr_reader :path

    TOTAL_SPACE = 70_000_000
    REQUIRED_SPACE = 30_000_000

    def initialize(path)
      @path = path
    end

    def call
      file_structure = Part1Solution::Terminal.new(path).call
      remaining_space = TOTAL_SPACE - file_structure.size

      sorted = file_structure.name_size.flatten.sort { |a, b| a.size <=> b.size }

      name_size = sorted.find do |ns|
        (remaining_space + ns.size) >= REQUIRED_SPACE
      end

      name_size.size
    end
  end
end
