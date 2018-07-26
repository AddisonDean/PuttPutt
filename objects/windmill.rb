class Windmill
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x, @y = x, y
    @image = Gosu::Image.new('resources/images/windmill.png')
    bottom_left_pt = Margo::Point.new(x - 75.0, y + 150.0)
    bottom_right_pt = Margo::Point.new(x + 50.0, y + 150.0)
    top_left_pt = Margo::Point.new(x - 15.0, y + 110.0)
    top_right_pt = Margo::Point.new(x + 100.0, y + 110.0)
    @top_edge = Margo::Line.new(top_left_pt, top_right_pt)
    @top_edge.set_react_cmd("$angle = 180.0 - $angle")
    @bottom_edge = Margo::Line.new(bottom_left_pt, bottom_right_pt)
    @bottom_edge.set_react_cmd("$angle = 180.0 - $angle")
    @left_edge = Margo::Line.new(top_left_pt, bottom_left_pt)
    @left_edge.set_react_cmd("$angle = 300.0")
    @right_edge = Margo::Line.new(top_right_pt, bottom_right_pt)
    @right_edge.set_react_cmd("$angle = 120.0")
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

  def detect_collision(delete_me_x, delete_me_y, ball_x, ball_y)
    if @top_edge.collision(ball_x, ball_y, 5)
      eval(@top_edge.react)
    end

    if @bottom_edge.collision(ball_x, ball_y, 5)
      eval(@bottom_edge.react)
    end

    if @left_edge.collision(ball_x, ball_y, 10)
      eval(@left_edge.react)
    end

    if @right_edge.collision(ball_x, ball_y, 10)
      eval(@right_edge.react)
    end
  end

  def draw
    @image.draw_rot(@x, @y, 3, 0)
  end
end