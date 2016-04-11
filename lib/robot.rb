class Robot
  attr_reader :location, :direction, :placed
  DIRECTION_NAMES = %i(north east south west)
  DIRECTION_STEPS = [{ x: 0 , y: 1 }, { x: 1, y: 0 }, { x: 0, y: -1 }, { x: -1, y: 0 }]

  def initialize(table_size)
    @table_size = table_size
  end

  def move
    return unless @placed
    direction_step = DIRECTION_STEPS[@direction]
    move_coordinates = { x: @location[:x] + direction_step[:x],
                         y: @location[:y] + direction_step[:y] }
    @location = move_coordinates if valid_location?(move_coordinates)
  end

  def place(x, y, direction_name)
    location = { x: x, y: y }
    if valid_location?(location) && valid_direction?(direction_name)
      @location = location
      @direction = DIRECTION_NAMES.index(direction_name)
      @placed = true
    end
  end

  def left
    @direction = (@direction - 1) % 4 if @placed
  end

  def right
    @direction = (@direction + 1) % 4 if @placed
  end

  def report
    puts "POSITION: #{@location[:x]}, #{@location[:y]}, #{direction_name}" if @placed
  end

  def direction_name
    DIRECTION_NAMES[@direction].to_s.upcase if @direction
  end

  private
  def valid_location?(location)
    location[:x].between?(0, @table_size[:x] - 1) && location[:y].between?(0, @table_size[:y] - 1)
  end

  def valid_direction?(direction_name)
    DIRECTION_NAMES.include?(direction_name)
  end
end
