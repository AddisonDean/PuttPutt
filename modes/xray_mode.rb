class Xray_mode
  def self.activated
    $ball.ghost_mode
    $special_objects.each do |obj|
      obj.ghost_mode
    end

    if !Gosu.button_down? Gosu::KB_X
      $ball.normal_mode
      $special_objects.each do |obj|
        obj.normal_mode
      end
      $game_stage = 'aim'
    end
  end
end