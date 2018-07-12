# Require GOSU
require 'gosu'
# Require Levels
require_relative 'levels/level_01'
require_relative 'levels/level_02'
# Require Objects
require_relative 'objects/ball'
require_relative 'objects/arrow'
require_relative 'objects/hole'
require_relative 'objects/windmill'
require_relative 'objects/pacman'
require_relative 'objects/river'
require_relative 'objects/bridge'
# Require Modes
require_relative 'modes/aim_mode'
require_relative 'modes/charge_mode'
require_relative 'modes/complete_mode'
require_relative 'modes/fire_mode'
require_relative 'modes/god_mode'
require_relative 'modes/xray_mode'

class Main_game < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Fiserv Putt Putt'
    @background_image = Gosu::Image.new('resources/images/title_field.png', :tileable => true)
    @play_button = Gosu::Image.new('resources/images/play_button.png')
    @inst_button = Gosu::Image.new('resources/images/instruction_button.png')
    $level_number = 0
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
        close
        $level_number += 1
        Level_01.new.show
      else
        puts 'INSTRUCTIONS'
      end
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @play_button.draw(220, 260, 1)
    @inst_button.draw(220, 340, 1)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

end

Main_game.new.show
