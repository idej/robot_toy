class CommandsList
  attr_reader :error, :commands

  def initialize(file_name, table_size)
    @file_name = file_name
    @table_size = table_size
    @commands = []
  end

  def parse
    begin
      @file = File.open(@file_name, 'r')
    rescue
      @error = "Can't find file #{@file_name}"
      return
    end
    parse_file
    @error = "File should contain valid PLACE command" if !@error && @commands.empty?
    @file.close
  end

  private
  def parse_file
    @file.each do |line|
      parse_command(line)
      break if @error
    end
  end

  def parse_command(line)
    command = line.strip.downcase
    case command
    when /\A(move|left|right|report)\z/
      @commands << command.to_sym unless @commands.empty?
    when /\Aplace -?\d+,\s?-?\d+,\s?(north|south|east|west)\z/
      matches = command.match(/(?<x>\d+),\s?(?<y>\d+),\s?(?<direction>\w*)/)
      if matches
        args = { command: :place,
                 x: matches['x'].to_i,
                 y: matches['y'].to_i,
                 direction: matches['direction'].to_sym }
        @commands << args if args[:x] < @table_size[:x] && args[:y] < @table_size[:y]
      end
    else
      @error = "Unknow command: #{line}"
    end
  end
end
