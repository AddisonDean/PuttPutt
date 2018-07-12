class Charge_mode
  @charge_factor = 2
  def self.activated(frame_count)
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
      if frame_count%@charge_factor == 0
        $ball.add_power
      end
    else
      $ball.set_angle($arrow.angle)
      $ball.add_stroke
      $game_stage = 'fire'
    end
  end
end