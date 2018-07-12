class Level_01 < Gosu::Window

  def initialize
    # Create window, apply background, create frame counter
    $window_width = 640
    $window_height = 480
    $font = Gosu::Font.new(20)
    super $window_width, $window_height
    self.caption = 'Fiserv Putt Putt'
    $frame = 0
    $background_image = Gosu::Image.new('resources/images/green_field.png', :tileable => true)

    # Create all standard objects and place
    $ball = Ball.new
    $ball.place(560, 440)
    $arrow = Arrow.new
    $arrow.place(560, 440)
    $hole = Hole.new(100,140)

    # Create special objects and place
    $windmill = Windmill.new(390, 150)
    $pacman = Pacman.new(140, 330)
    $special_objects = [$windmill, $pacman]

    # Set initial mode, 'aim'
    $game_stage = 'aim'
  end

  def update
    $frame += 1
    $frame %= 60
    if $game_stage == 'aim'
      Aim_mode.activated
    end
    if $game_stage == 'charge'
      Charge_mode.activated($frame)
    end
    if $game_stage == 'fire'
      Fire_mode.activated
    end
    if $game_stage == 'complete'
      Complete_mode.activated
    end
    if $game_stage == 'xray'
      Xray_mode.activated
    end
    if $game_stage == 'GOD'
      God_mode.activated
    end
  end

  def draw
    $background_image.draw(0, 0, 0)
    $ball.draw
    $arrow.draw
    $hole.draw
    $windmill.draw
    $pacman.draw
    if $game_stage == 'complete'
      $font.draw("Thanks for playing!", 310, 220, 0, 1.0, 1.0, Gosu::Color::BLACK)
      $font.draw("Your score was: #{$ball.score}", 310, 240, 0, 1.0, 1.0, Gosu::Color::BLACK)
      $font.draw("Press 'F' key to play next level.", 310, 280, 0, 1.0, 1.0, Gosu::Color::BLACK)
    else
      $font.draw("Score: #{$ball.score}", 40, 10, 0, 1.0, 1.0, Gosu::Color::BLACK)
      $font.draw("Power: #{$ball.power}", 520, 10, 0, 1.0, 1.0, Gosu::Color::RED)
    end
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end


