class Ball
  attr_reader :power
  attr_reader :score
  attr_accessor :fallen
  attr_reader :x
  attr_reader :y

  def initialize
    @image = Gosu::Image.new('resources/images/ball.png')
    @x = @y = 0.0
    @power = 0
    @score = 0
    $angle = 0.0
    @gm = false
    @add = true
    @fallen = false
  end

  def place(x, y)
    @x, @y = x, y
  end

  def set_angle(angle)
    $angle = angle
  end

  def ghost_mode
    @gm = true
    @image = Gosu::Image.new('resources/images/ghost_ball.png')
  end

  def normal_mode
    @gm = false
    @image = Gosu::Image.new('resources/images/ball.png')
  end

  def set_fallen
    @power = 1
    @fallen = true
  end

  def move(window_width, window_height)
    increment = 1
    total_time = @initial_power / increment
    current_time = @initial_power - (@initial_power - @power)
    velocity = ((current_time / (total_time * 1.0)) * 6 + 1).round(0)
    if @power > 0
      next_x_pos = @x + Gosu.offset_x($angle, velocity)
      next_y_pos = @y + Gosu.offset_y($angle, velocity)
      # Check for collisions with all special objects
      $special_objects.each do |obj|
        obj.detect_collision(obj.x, obj.y, next_x_pos, next_y_pos)
      end

      if $left_wall.collision(next_x_pos, next_y_pos, 50)
        eval($left_wall.react)
      end

      if $right_wall.collision(next_x_pos, next_y_pos, 50)
        eval($right_wall.react)
      end

      if $top_border.collision(next_x_pos, next_y_pos, 5)
        eval($top_border.react)
      end

      if $bottom_border.collision(next_x_pos, next_y_pos, 5)
        eval($bottom_border.react)
      end

      @x = next_x_pos.round(1)
      @y = next_y_pos.round(1)
      @power -= increment
    end
  end


  def add_power
    @add ? @power += 10 : @power -= 10
    @add = false if @power == 250
    @add = true if @power == 0
    # delete this
    # @power = 250.0
    @initial_power = @power
  end

  def add_stroke
    @add = true
    @score += 1
  end

  def draw
    # This will make the ball appear above anything else in ghostmode
    if @gm
      @image.draw_rot(@x, @y, 5, 0)
    else
      @image.draw_rot(@x, @y, 2, 0)
    end
  end
end