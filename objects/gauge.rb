class Gauge
    def initialize(x, y)
      @x, @y = x, y
      @image = Gosu::Image.new('resources/images/gauge/gauge_00.png')
    end

    def determine_power(power_level)
      power_level = ((power_level / 10) / 1.67).round(0)
      if power_level < 10
        power_level = "0#{power_level}"
      end
      pic_name = "resources/images/gauge/gauge_#{power_level}.png"
      @image = Gosu::Image.new(pic_name)
    end

    def go_invisible
      @image = Gosu::Image.new('resources/images/blank.png')
    end

    def draw
      @image.draw(@x, @y, 0, 0.5, 0.5)
    end
end