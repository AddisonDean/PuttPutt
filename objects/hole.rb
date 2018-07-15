class Hole
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x, @y = x, y
    @image = Gosu::Image.new('resources/images/hole.png')
  end

  def draw
    @image.draw_rot(@x, @y, 0, 0)
  end
end