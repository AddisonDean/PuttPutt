class God_mode
  def self.activated
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
end