class Complete_mode
  def self.activated
    $arrow.go_invisible
    $special_objects.each do |obj|
      obj.go_invisible
    end

    # Do something here before the game restarts, like, add an entry to the
    # 'leaderboard' and then show the leaderboard until a button is pressed
    if Gosu.button_down? Gosu::KB_F
      $level_number += 1
      # close
      if $level_number == 2
        Level_02.new.show
      end
      if $level_number == 3
        #Level_03.new.show
      end
    end
  end
end