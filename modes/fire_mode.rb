class Fire_mode
  def self.activated
    $ball.move($window_width, $window_height)
    if $ball.power == 0
      $arrow.place($ball.x, $ball.y)
      $game_stage = 'aim'
    end
    if Gosu.distance($ball.x, $ball.y, $hole.x, $hole.y) < 10
      $game_stage = 'complete'
    end
  end
end