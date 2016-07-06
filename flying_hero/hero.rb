require 'gosu'

class Hero

  def initialize

    @sprites = Gosu::Image::load_tiles('assets/images/cat.png', 847/6, 87, tileable: false)

    @x = 10
    @y = 200
    @width = @sprites.first.width
    @height = @sprites.first.height

  end

  def draw
    sprite = @sprites[Gosu::milliseconds / 75% @sprites.size]
    sprite.draw(@x, @y, 1)
  end
  def move_up!
    if @y > 0
    @y -= 15
    end
  end
  def move_down!(window_height)

    if (@y + @height)  <= window_height
    @y += 15
    end
  end
  def bumped_into?(object)
    if (@y > object.y + object.height) || (@y + @height < object.y) || (@x > object.x + object.width) || (@x + @width < object.x)
      false
    else
      true
    end
  end
end
