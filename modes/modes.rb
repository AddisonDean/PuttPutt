class Modes
  def self.aim_mode
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

  def self.charge_mode(frame_count)
    @charge_factor = 2
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

  def self.complete_mode
    $arrow.go_invisible
    $special_objects.each do |obj|
      obj.go_invisible
    end

    # Do something here before the game restarts, like, add an entry to the
    # 'leaderboard' and then show the leaderboard until a button is pressed

    # Open next level's window.
    if Gosu.button_down? Gosu::KB_F
      $level_number += 1
      if $level_number > $level_list.length
        # TODO: Add a score display/ request to start new game here.
        exit(0)
      else
        $level_list[$level_number-1].new.show
      end
    end
  end

  def self.fire_mode
    $ball.move($window_width, $window_height)
    if $ball.power == 0
      $arrow.place($ball.x, $ball.y)
      $game_stage = 'aim'
    end
    if Gosu.distance($ball.x, $ball.y, $hole.x, $hole.y) < 10
      $game_stage = 'complete'
    end
  end

  def self.god_mode
    puts "X Value: #{$ball.x}"
    puts "Y Value: #{$ball.y}"
    if Gosu.button_down? Gosu::KB_LEFT
      $ball.place(($ball.x - 5.0), $ball.y)
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      $ball.place(($ball.x + 5.0), $ball.y)
    end
    if Gosu.button_down? Gosu::KB_UP
      $ball.place($ball.x, ($ball.y - 5.0))
    end
    if Gosu.button_down? Gosu::KB_DOWN
      $ball.place($ball.x, ($ball.y + 5.0))
    end
    if Gosu.button_down? Gosu::KB_W
      $arrow.place($ball.x, $ball.y)
      $game_stage = 'aim'
    end
  end

  def self.xray_mode
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