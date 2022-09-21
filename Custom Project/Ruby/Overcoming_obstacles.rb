require 'gosu'

$speed = 0

class Brick 
    def initialize
        @brick = Gosu::Image.new('Media/Image_Bricks.png')
        @x = 1100
        @y = 0
    end

    def update
        @x -= $speed
    end

    def draw
        @brick.draw(@x, @y, 0)
    end
end

class OvercomingObstacles < Gosu::Window
    def initialize
        super(1100, 540)
        self.caption = 'Overcoming Obstacles'
        @sky_background = Gosu::Image.new('Media/Image_Sky_and_Grass.jpg')
        @easy_image = Gosu::Image.new('Media/Image_Easy_Button.png')
        @hard_image = Gosu::Image.new('Media/Image_Hard_Button.png')
        @superhard_image = Gosu::Image.new('Media/Image_Super_hard_Button.png')
        @bird = Gosu::Image.load_tiles('Media/Image_Bird.png', 54, 50)
        @font = Gosu::Font.new(30)
        @bricks = []
        @playing = @playing_1 = @x0 = @x = @i = @time = @time_1 = @start_time = @score = @bird_y = @i = @k = @l = 0
        @j = false
    end

    def easy_click(mouse_x, mouse_y)
        if ((mouse_x > 110 and mouse_x < 260) && (mouse_y > 280 and mouse_y < 335))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def hard_click(mouse_x, mouse_y)
        if ((mouse_x > 470 and mouse_x < 620) and (mouse_y > 280 and mouse_y < 335))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def superhard_click(mouse_x, mouse_y)
        if ((mouse_x > 830 and mouse_x < 980) and (mouse_y > 280 and mouse_y < 335))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def button_down(id)
        if (@playing == 0)
            if (id == Gosu::MsRight)
                @playing = -1
            elsif (id == Gosu::MsLeft)
                if (easy_click(mouse_x, mouse_y)) || (hard_click(mouse_x, mouse_y)) || (superhard_click(mouse_x, mouse_y))
                    if easy_click(mouse_x, mouse_y)
                        $speed = 3
                    elsif hard_click(mouse_x, mouse_y)
                        $speed = 6
                    elsif superhard_click(mouse_x, mouse_y)
                        $speed = 10
                    end
                    @playing = 1
                    @playing_1 = @x0 = @x = @k = @time = @score = 0
                end
            end
        elsif (@playing == 1)
            if (id == Gosu::KbSpace)
                @start_time = Gosu.milliseconds if (@playing_1 == 0)
                @playing_1 = @l = 1
                @time_1 = @time
            end
        end
        if (id == Gosu::KbK) && (@playing != 0)
            @playing = 0
        elsif (id == Gosu::KbEscape)
            close
            Menu.new.show
        end
    end

    def update
        if (@playing == 0)
            @x0 -= 1
        elsif (@playing == 1)
            if (@playing_1 == 0)
                @bird_y = 240
            elsif (@playing_1 == 1)
                @time = Gosu.milliseconds - @start_time
                @bird_y += 3
                if (@l == 1) && ((@time - @time_1) <= 280)
                    @bird_y -= 7
                elsif ((@time - @time_1) > 280)
                    @l = 0
                end
            end
            @x -= $speed
            if (@time >= 10000) && (@time < 20000) && (@k == 0)
                $speed += 1
                @k += 1
            elsif (@time >= 20000) && (@time < 30000) && (@k == 1)
                $speed += 1
                @k += 1
            elsif (@time >= 30000) && (@time < 40000) && (@k == 2)
                $speed += 1
                @k += 1
            elsif (@time >= 40000) && (@time < 50000) && (@k == 3)
                $speed += 1
                @k += 1
            elsif (@time >= 50000) && (@time < 60000) && (@k == 4)
                $speed += 1
                @k += 1
            elsif (@time >= 60000) 
                @playing = 2
            end
            @playing = 2 if (@bird_y > 424)
        end
    end

    def draw
        if (@playing == 0)
            @sky_background.draw(@x0, 0, 0)
            @sky_background.draw(@x0 + 550, 0, 0)
            @sky_background.draw(@x0 + 1100, 0, 0)
            @x0 = 0 if (@x0 <= -550)
            if easy_click(mouse_x, mouse_y)
                Gosu.draw_rect(105, 275, 160, 65, Gosu::Color.argb(0xff_ff00ff), 0)
            elsif hard_click(mouse_x, mouse_y)
                Gosu.draw_rect(465, 275, 160, 65, Gosu::Color.argb(0xff_ff00ff), 0)
            elsif superhard_click(mouse_x, mouse_y)
                Gosu.draw_rect(825, 275, 160, 65, Gosu::Color.argb(0xff_ff00ff), 0)
            end
            @easy_image.draw(110, 280, 0)
            @hard_image.draw(470, 280, 0)
            @superhard_image.draw(830, 280, 0)
        elsif (@playing == 1)
            @sky_background.draw(@x, 0, 0)
            @sky_background.draw(@x + 550, 0, 0)
            @sky_background.draw(@x + 1100, 0, 0)
            @x = 0 if (@x <= -550)   
            @font.draw('Press Space to begin ... ', 450, 20, 0, 0.8, 0.8, Gosu::Color.argb(0xff_ff00ff)) if (@playing_1 == 0)
            @font.draw('Your Score: ' + @score.to_s, 10, 10, 0, 1.0, 1.0, Gosu::Color::RED)
            @font.draw('Time: ' + (@time / 1000).to_s, 20, 480, 0, 0.8, 0.8, Gosu::Color::RED)
            @font.draw('Speed: ' + $speed.to_s, 990, 480, 0, 0.8, 0.8, Gosu::Color::RED)
            if (@bird_y <= 424)
                if (@i < @bird.count)
                    @bird[@i].draw_rot(150, @bird_y, 0)
                    @i += 1
                else
                    @j = false
                    @i = 0
                end
                @j = true
            else
                @bird[@i].draw_rot(150, @bird_y, 0)
            end
        elsif (@playing == 2)
            @sky_background.draw(@x, 0, 0)
            @sky_background.draw(@x + 550, 0, 0)
            @sky_background.draw(@x + 1100, 0, 0)
            @x = 0 if (@x <= -550)
            @bird[@i].draw_rot(150, @bird_y, 0)
            @font.draw('<b> GAME OVER </b>', 345, 60, 0, 2.5, 2.5, Gosu::Color::RED) if ((Gosu.milliseconds - @start_time - @time) >= 1000)
        end
    end
end

OvercomingObstacles.new.show