class Aim_mode
  def self.activated
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      $arrow.turn_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      $arrow.turn_right
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
      $game_stage = 'charge'
    end
    if Gosu.button_down? Gosu::KB_X
      $game_stage = 'xray'
    end
    if Gosu.button_down? Gosu::KB_Q
      $game_stage = 'GOD'
    end
  end
end