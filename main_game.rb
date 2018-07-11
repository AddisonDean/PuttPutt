require 'gosu'
require_relative 'ball'
require_relative 'arrow'
require_relative 'hole'
require_relative 'windmill'
require_relative 'pacman'

class Game_Window < Gosu::Window


  def initialize
    @frame = 0
    @charge_factor = 2
    @window_width = 640
    @window_height = 480
    super @window_width, @window_height
    self.caption = 'Fiserv Putt Putt'
    @font = Gosu::Font.new(20)
    @background_image = Gosu::Image.new('resources/images/3d_green.png', :tileable => true)
    @ball = Ball.new
    @ball.place(560, 440)
    @arrow = Arrow.new
    @arrow.place(560, 440)
    @hole = Hole.new(100,140)
    @windmill = Windmill.new(390, 150)
    @pacman = Pacman.new(140, 330)
    # This can be title, aim, charge, fire, xray, GOD, complete
    @game_stage = 'aim'
  end

  def update
    @frame += 1
    @frame %= 60
    if @game_stage == 'aim'
      if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
        @arrow.turn_left
      end
      if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
        @arrow.turn_right
      end
      if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
        @game_stage = 'charge'
      end
      if Gosu.button_down? Gosu::KB_X
        @game_stage = 'xray'
      end
      if Gosu.button_down? Gosu::KB_Q
        @game_stage = 'GOD'
      end
    end
    if @game_stage == 'charge'
      if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
        if @frame%@charge_factor == 0
          @ball.add_power
        end
      else
        @ball.set_angle(@arrow.angle)
        @game_stage = 'fire'
      end
    end
    if @game_stage == 'fire'
      @ball.move(@window_width, @window_height, @windmill.x, @windmill.y, @pacman.x, @pacman.y)
      if @ball.power == 0
        @ball.add_stroke
        @arrow.place(@ball.x, @ball.y)
        @game_stage = 'aim'
      end
      if Gosu.distance(@ball.x, @ball.y, @hole.x, @hole.y) < 10
        @game_stage = 'complete'
      end
    end
    if @game_stage == 'complete'
      @windmill.go_invisible
      @pacman.go_invisible
      @arrow.go_invisible
      # Do something here before the game restarts, like, add an entry to the
      # 'leaderboard' and then show the leaderboard until a button is pressed
      if Gosu.button_down? Gosu::KB_F
        initialize
      end
    end
    if @game_stage == 'xray'
      @windmill.ghost_mode
      @pacman.ghost_mode
      @ball.ghost_mode
      if !Gosu.button_down? Gosu::KB_X
        @windmill.normal_mode
        @pacman.normal_mode
        @ball.normal_mode
        @game_stage = 'aim'
      end
    end
    if @game_stage == 'GOD'
      puts "X Value: #{@ball.x}"
      puts "Y Value: #{@ball.y}"
      if Gosu.button_down? Gosu::KB_LEFT
        @ball.place((@ball.x - 5.0), @ball.y)
      end
      if Gosu.button_down? Gosu::KB_RIGHT
        @ball.place((@ball.x + 5.0), @ball.y)
      end
      if Gosu.button_down? Gosu::KB_UP
        @ball.place(@ball.x, (@ball.y - 5.0))
      end
      if Gosu.button_down? Gosu::KB_DOWN
        @ball.place(@ball.x, (@ball.y + 5.0))
      end
      if Gosu.button_down? Gosu::KB_W
        @arrow.place(@ball.x, @ball.y)
        @game_stage = 'aim'
      end
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @ball.draw
    @arrow.draw
    @hole.draw
    @windmill.draw
    @pacman.draw
    if @game_stage == 'complete'
      @font.draw("Thanks for playing!", 310, 220, 0, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Your score was: #{@ball.score}", 310, 240, 0, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Press 'F' key to play again.", 310, 280, 0, 1.0, 1.0, Gosu::Color::BLACK)
    else
      @font.draw("Score: #{@ball.score}", 40, 10, 0, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw("Power: #{@ball.power}", 520, 10, 0, 1.0, 1.0, Gosu::Color::RED)
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

Game_Window.new.show