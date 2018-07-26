class Pacman
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x, @y = x, y
    @image = Gosu::Image.new('resources/images/pacman.png')
    bottom_left_pt = Margo::Point.new(x - 60.0, y + 85.0)
    bottom_right_pt = Margo::Point.new(x + 35.0, y + 85.0)
    top_left_pt = Margo::Point.new(x - 40.0, y + 50.0)
    top_right_pt = Margo::Point.new(x + 55.0, y + 50.0)
    @top_edge = Margo::Line.new(top_left_pt, top_right_pt)
    @top_edge.set_react_cmd("$angle = 180.0 - $angle")
    @bottom_edge = Margo::Line.new(bottom_left_pt, bottom_right_pt)
    @bottom_edge.set_react_cmd("$angle = 180.0 - $angle")
    # I want these to perform the same calculations that ball.rb does when hitting the sides of the field,
    # But that keeps glitching. I'll work on it.
    @left_edge = Margo::Line.new(top_left_pt, bottom_left_pt)
    @left_edge.set_react_cmd("$angle = 290.0")
    @right_edge = Margo::Line.new(top_right_pt, bottom_right_pt)
    @right_edge.set_react_cmd("$angle = 110.0")
  end

  def ghost_mode
    @image = Gosu::Image.new('resources/images/ghost_pacman.png')
  end

  def normal_mode
    @image = Gosu::Image.new('resources/images/pacman.png')
  end

  def go_invisible
    @image = Gosu::Image.new('resources/images/blank.png')
  end

  def detect_collision(x, y, ball_x, ball_y)
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