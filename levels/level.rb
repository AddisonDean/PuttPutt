class Level < Gosu::Window
  def initialize
    # Create window, apply background, create frame counter
    $window_width = 640
    $window_height = 480
    $font = Gosu::Font.new(20)
    super $window_width, $window_height
    self.caption = 'Fiserv Putt Putt'
    $frame = 0

    # Set up borders of play area within window
    # Top border
    @pt_top_left = Margo::Point.new(50, 100)
    @pt_top_right = Margo::Point.new(590, 100)
    $top_border = Margo::Line.new(@pt_top_left, @pt_top_right)
    $top_border.set_react_cmd("$angle = 180.0 - $angle")

    # Bottom border
    @pt_bottom_left = Margo::Point.new(0, 479)
    @pt_bottom_right = Margo::Point.new(639, 479)
    $bottom_border = Margo::Line.new(@pt_bottom_left, @pt_bottom_right)
    $bottom_border.set_react_cmd("$angle = 180.0 - $angle")

    # Left Wall (angled)
    $left_wall = Margo::Line.new(@pt_bottom_left, @pt_top_left)
    $left_wall.set_react_cmd("$angle = 360.0 - $angle")

    # Right Wall (angled)
    $right_wall = Margo::Line.new(@pt_bottom_right, @pt_top_right)
    $right_wall.set_react_cmd("$angle = 360.0 - $angle")

    # Create all standard objects and place
    $ball = Ball.new
    $ball.place(560, 440)
    $arrow = Arrow.new
    $arrow.place(560, 440)
    $hole = Hole.new(100,140)
    $gauge = Gauge.new(480, 10)

    # Set initial mode, 'aim'
    $game_stage = 'aim'
  end

  def update
    $frame += 1
    $frame %= 60
    if $game_stage == 'aim'
      Modes.aim_mode
    end
    if $game_stage == 'charge'
      Modes.charge_mode($frame)
    end
    if $game_stage == 'fire'
      Modes.fire_mode($frame)
    end
    if $game_stage == 'complete'
      Modes.complete_mode
    end
    if $game_stage == 'xray'
      Modes.xray_mode
    end
    if $game_stage == 'GOD'
      Modes.god_mode
    end

    if Gosu.button_down? Gosu::KB_ESCAPE
      exit(0)
    end
  end

  def draw
    $background_image.draw(0, 0, 0)
    $ball.draw
    $arrow.draw
    $hole.draw
    $special_objects.each do |obj|
      obj.draw
    end
    if $game_stage == 'complete'
      $font.draw("Thanks for playing!", 310, 220, 0, 1.0, 1.0, Gosu::Color::BLACK)
      $font.draw("Your score was: #{$ball.score}", 310, 240, 0, 1.0, 1.0, Gosu::Color::BLACK)
      $font.draw("Press 'F' key to play next level.", 310, 280, 0, 1.0, 1.0, Gosu::Color::BLACK)
    else
      $font.draw("Score: #{$ball.score}", 40, 10, 0, 1.0, 1.0, Gosu::Color::BLACK)
      $gauge.draw
    end
  end
end