class Levels
  class Level_01 < Level
    def initialize
      super
      $background_image = Gosu::Image.new('resources/images/green_field.png', :tileable => true)
      # Create special objects and place
      $windmill = Windmill.new(390, 150)
      $pacman = Pacman.new(140, 330)
      $special_objects = [$windmill, $pacman]
    end
  end

  class Level_02 < Level
    def initialize
      super
      $background_image = Gosu::Image.new('resources/images/hell_field.png', :tileable => true)
      # Create special objects and place
      $river = River.new(320,291)
      $bridge = Bridge.new(330, 300)
      $special_objects = [$river, $bridge]
    end
  end
end