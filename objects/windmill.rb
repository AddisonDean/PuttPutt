class Windmill
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x, @y = x, y
    @image = Gosu::Image.new('resources/images/windmill.png')
  end

  def calculate(x, y)
    @left_edge = x - 75.0
    @right_edge = x + 50.0
    @top_edge = y + 110.0
    @bottom_edge = y + 150.0
  end

  def ghost_mode
    @image = Gosu::Image.new('resources/images/ghost_windmill.png')
  end

  def normal_mode
    @image = Gosu::Image.new('resources/images/windmill.png')
  end

  def go_invisible
    @image = Gosu::Image.new('resources/images/blank.png')
  end

  def detect_collision(x, y, ball_x, ball_y)
    calculate(x, y)

    if @left_edge <= ball_x && @right_edge >= ball_x
      if (@bottom_edge - 3) <= ball_y && (@bottom_edge + 5) >= ball_y
        $angle = 180.0 - $angle
      end
    end

    if (@left_edge + 60.0) <= ball_x && (@right_edge + 60.0) >= ball_x
      if (@top_edge - 5) <= ball_y && (@top_edge + 3) >= ball_y
        $angle = 180.0 - $angle
      end
    end

    if ball_y <= @bottom_edge && ball_y >= @top_edge
      @y_delta = 1.0 - ((ball_y - 260.0)/ 40.0)
      if ball_x >= ((@left_edge - 10) + @y_delta * 50) && ball_x <= ((@left_edge + 50) + @y_delta * 50)
        # I want this to perform the same calculations in ball.rb that hitting the sides of the field does,
        # But that keeps glitching. I'll work on it.
        $angle = 300.0
      end

      if ball_x >= ((@right_edge - 50) + @y_delta * 50) && ball_x <= ((@right_edge + 25) + @y_delta * 50)
        # I want this to perform the same calculations in ball.rb that hitting the sides of the field does,
        # But that keeps glitching. I'll work on it.
        $angle = 120.0
      end
    end
  end

  def draw
    @image.draw_rot(@x, @y, 3, 0)
  end
end