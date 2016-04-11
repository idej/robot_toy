require_relative 'commands_list'
require_relative 'robot'

class Application
  TABLE_SIZE = { x: 5, y: 5 }

  def initialize(file_name)
    @command_list = CommandsList.new(file_name, TABLE_SIZE)
    @command_list.parse
    @robot = Robot.new(TABLE_SIZE)
  end

  def run
    if !@command_list.error
      @command_list.commands.each do |c|
        c.is_a?(Hash) ? @robot.send(c[:command], c[:x], c[:y], c[:direction]) : @robot.send(c)
      end
    else
      puts @command_list.error
    end
  end
end
