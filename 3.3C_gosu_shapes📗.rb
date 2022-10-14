# By MOON

require "rubygems"
require "gosu"

class Circle
  attr_reader :columns, :rows

  def initialize(radius)
    @columns = @rows = radius * 2

    clear, solid = 0x00.chr, 0xff.chr

    lower_half = (0...radius).map do |y|
      x = Math.sqrt(radius ** 2 - y ** 2).round
      right_half = "#{solid * x}#{clear * (radius - x)}"
      right_half.reverse + right_half
    end.join
    alpha_channel = lower_half.reverse + lower_half
    # Expand alpha bytes into RGBA color values.
    @blob = alpha_channel.gsub(/./) { |alpha| solid * 3 + alpha }
  end

  def to_blob
    @blob
  end
end

module ZOrder
    BACKGROUND, MIDDLE, TOP = *0..2
end
  
class DemoWindow < Gosu::Window
    def initialize
      super(800, 600, false)
      self.caption = ("House Drawing")
    end
  
    def draw
      # see www.rubydoc.info/github/gosu/gosu/Gosu/Color for colours
      draw_quad(0, 0, 0xff_ffffff, 800, 0, 0xff_ffffff, 0, 600, 0xff_ffffff, 800, 600, 0xff_ffffff, ZOrder::BACKGROUND)
      draw_triangle(400, 180, Gosu::Color::RED, 550, 300, Gosu::Color::RED, 250, 300, Gosu::Color::RED, ZOrder::TOP, mode=:default)  
      Gosu.draw_rect(300, 300, 200, 200, Gosu::Color::GRAY, ZOrder::MIDDLE, mode=:default)
      img2 = Gosu::Image.new(Circle.new(400))
      img2.draw(0, 400, ZOrder::BACKGROUND, 1.0, 0.5, Gosu::Color::GREEN)
    end
  end
  
  DemoWindow.new.show
