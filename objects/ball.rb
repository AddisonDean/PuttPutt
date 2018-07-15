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

  def move(window_width, window_height)
    # You should make this an even factor of 1 (.1, .2, .25, .5, 1)
    increment = 1
    velocity_scale = 10
    distance = increment * velocity_scale
    if @power > 0
      @x += Gosu.offset_x($angle, distance)
      @y += Gosu.offset_y($angle, distance)
      @y_delta = 1.0 - ((@y - 100.0)/ 380.0)

      # Check for collisions with all special objects
      $special_objects.each do |obj|
        obj.detect_collision(obj.x, obj.y, @x, @y)
      end

      # If the ball hits the left or right of the field
      if @x <= (@y_delta * 50.0) + 15.0 or @x >= (window_width - 15.0) - (@y_delta * 50)
        $angle = 360.0 - $angle
      end

      # If the ball hits the top of the field
      if @y <= 100
        $angle = 180.0 - $angle
      end

      # If the ball hits the bottom of the field
      if @y >= window_height - 15
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
    # This will make the ball appear above anything else in ghostmode
    if @gm
      @image.draw_rot(@x, @y, 5, 0)
    else
      @image.draw_rot(@x, @y, 2, 0)
    end
  end
end