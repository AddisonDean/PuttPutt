class River
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x, @y = x, y
    @image = Gosu::Image.new('resources/images/hell_river.png')
    bottom_left_pt = Margo::Point.new(x - 75.0, y + 190.0)
    bottom_right_pt = Margo::Point.new(x + 80.0, y + 190.0)
    top_left_pt = Margo::Point.new(x - 75.0, y - 190.0)
    # slight x difference to compensate for margo error. TODO: Fix Margo!
    top_right_pt = Margo::Point.new(x + 100.0, y - 190.0)
    @left_edge = Margo::Line.new(top_left_pt, bottom_left_pt)
    @left_edge.set_react_cmd("$ball.set_fallen")
    @right_edge = Margo::Line.new(top_right_pt, bottom_right_pt)
    @right_edge.set_react_cmd("$ball.set_fallen")
  end

  def ghost_mode
    @image = Gosu::Image.new('resources/images/hell_river.png')
  end

  def normal_mode
    @image = Gosu::Image.new('resources/images/hell_river.png')
  end

  def go_invisible
    @image = Gosu::Image.new('resources/images/blank.png')
  end

  def detect_collision(x, y, ball_x, ball_y)
    if $ball.fallen

    end
    if @left_edge.collision(ball_x, ball_y, 5)
      puts 'success'
      eval(@left_edge.react)
    end

    if @right_edge.collision(ball_x, ball_y, 5)
      puts 'success'
      eval(@right_edge.react)
    end
  end

  def draw
    @image.draw_rot(@x, @y, 0, 0)
  end

end