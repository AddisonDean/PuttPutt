require_relative 'windmill'
require_relative 'pacman'

class Ball
  attr_reader :power
  attr_reader :score
  attr_reader :x
  attr_reader :y

  def initialize
    @image = Gosu::Image.new('resources/images/ball.png')
    @x = @y = 0.0
    @power = 0
    @score = 0
    $angle = 0.0
    @gm = false
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

  def move(window_width, window_height, windmill_x, windmill_y, pacman_x, pacman_y)
    increment = 1
    velocity_scale = 10
    distance = increment * velocity_scale
    # puts $angle
    if @power > 0
      @x += Gosu.offset_x($angle, distance)
      @y += Gosu.offset_y($angle, distance)
      @y_delta = 1.0 - ((@y - 100.0)/ 380.0)

      if @x <= (@y_delta * 50.0) + 15.0 #or
          #Windmill.detect_collision(windmill_x, windmill_y, @x, @y) == 'right' or
          #Pacman.detect_collision(pacman_x, pacman_y, @x, @y) == 'right'
        $angle = 360.0 - $angle
      end

      if @x >= (window_width - 15.0) - (@y_delta * 50) #or
          #Windmill.detect_collision(windmill_x, windmill_y, @x, @y) == 'left' or
          #Pacman.detect_collision(pacman_x, pacman_y, @x, @y) == 'left'
        $angle = 360.0 - $angle
      end

      # If the ball hits the top of the screen, Or the bottom of either obstacle
      if @y <= 100 or
          Windmill.detect_collision(windmill_x, windmill_y, @x, @y) == 'bottom' or
          Pacman.detect_collision(pacman_x, pacman_y, @x, @y) == 'bottom'
        $angle = 180.0 - $angle
      end

      # If the ball hits the bottom of the screen, Or the top of either obstacle
      if @y >= window_height - 15 or
          Windmill.detect_collision(windmill_x, windmill_y, @x, @y) == 'top' or
          Pacman.detect_collision(pacman_x, pacman_y, @x, @y) == 'top'
        $angle = 180.0 - $angle
      end
      @power -= increment
    end
  end

  def add_power
    @power += 5
    @power %= 100
  end

  def add_stroke
    @score += 1
  end

  def draw
    if @gm
      @image.draw_rot(@x, @y, 5, 0)
    else
      @image.draw_rot(@x, @y, 2, 0)
    end
  end
end