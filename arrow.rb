require 'gosu'

class Arrow
  attr_accessor :angle

  def initialize
    @image = Gosu::Image.new('resources/images/arrow.png')
    @x = @y = @angle = 0.0
  end

  def place(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 3
    @angle %= 360
  end

  def turn_right
    @angle += 3
    @angle %= 360
  end

  def go_invisible
    @image = Gosu::Image.new('resources/images/blank.png')
  end

  def draw
    @image.draw_rot(@x, @y, 4, @angle)
  end
end