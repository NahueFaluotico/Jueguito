require "gosu"
require_relative "background"
require_relative 'hero'
require_relative "candy"
require_relative "asteroid_big"
require_relative "asteroid_small"
require_relative "score_board"

class Game < Gosu::Window
  def initialize
    super(900, 550, fullscreen: false)
    self.caption = "Flying Hero!"
    @background = Background.new
    @hero = Hero.new
    @candy = Candy.new(self)
    @scoreboard = ScoreBoard.new
    set_asteroid
  end



  def draw

    @background.draw
    @hero.draw
    @candy.draw
    @asteroid.draw
    @scoreboard.draw

  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def update

    @background.scroll!
    if button_down?(Gosu::KbUp)
      @hero.move_up!
    end
    if button_down?(Gosu::KbDown)
      @hero.move_down!(self.height)
    end

    @candy.move!

    if @candy.x < 0
      @candy.reset!(self)
    end
    @asteroid.move!
    if @asteroid.x < 0
      set_asteroid

    end
    if @hero.bumped_into?(@candy)

      @candy.reset!(self)
      @scoreboard.update_score!(@candy.points)

    end
    if @hero.bumped_into?(@asteroid)

      @asteroid.reset!(self)
      @scoreboard.update_score!(@asteroid.points)

    end
  end
  def set_asteroid

    @asteroid = @asteroid && @asteroid.instance_of?(AsteroidBig) ?
    AsteroidSmall.new(self) : AsteroidBig.new(self)
  end
end
