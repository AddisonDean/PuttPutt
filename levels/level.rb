class Level < Gosu::Window
  def initialize
    # Create window, apply background, create frame counter
    $window_width = 640
    $window_height = 480
    $font = Gosu::Font.new(20)
    super $window_width, $window_height
    self.caption = 'Fiserv Putt Putt'
    $frame = 0

    # Create all standard objects and place
    $ball = Ball.new
    $ball.place(560, 440)
    $arrow = Arrow.new
    $arrow.place(560, 440)
    $hole = Hole.new(100,140)

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
      Modes.fire_mode
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
      $font.draw("Power: #{$ball.power}", 520, 10, 0, 1.0, 1.0, Gosu::Color::RED)
    end
  end
end