# Require GOSU, Margo
require 'gosu'
require 'margo'
# Require Levels
require_relative 'levels/level'
require_relative 'levels/levels'
# Require Objects
require_relative 'objects/ball'
require_relative 'objects/arrow'
require_relative 'objects/hole'
require_relative 'objects/windmill'
require_relative 'objects/pacman'
require_relative 'objects/river'
require_relative 'objects/bridge'
# Require Modes
require_relative 'modes/modes'

class Main_game < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Fiserv Putt Putt'
    @background_image = Gosu::Image.new('resources/images/title_field.png', :tileable => true)
    @play_button = Gosu::Image.new('resources/images/play_button.png')
    @inst_button = Gosu::Image.new('resources/images/instruction_button.png')
    $level_number = 0
    # While working on look and feel, only one level.
    # $level_list = [Levels::Level_01, Levels::Level_02]
    $level_list = [Levels::Level_01]
    @button_selected = 0
  end

  def update
    if Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::KB_DOWN
      @button_selected += 1
      @button_selected %= 2
      sleep(0.25)
    end
    if @button_selected == 0
      @play_button = Gosu::Image.new('resources/images/play_button_highlighted.png')
      @inst_button = Gosu::Image.new('resources/images/instruction_button.png')
    else
      @play_button = Gosu::Image.new('resources/images/play_button.png')
      @inst_button = Gosu::Image.new('resources/images/instruction_button_highlighted.png')
    end

    if Gosu.button_down? Gosu::KB_RETURN
      if @button_selected == 0
        $level_number += 1
        Levels::Level_01.new.show
      else
        puts 'INSTRUCTIONS'
      end
    end

    if Gosu.button_down? Gosu::KB_ESCAPE
      exit(0)
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @play_button.draw(220, 260, 1)
    @inst_button.draw(220, 340, 1)
  end

end

Main_game.new.show
