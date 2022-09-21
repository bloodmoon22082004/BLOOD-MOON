require 'gosu'
require './Gems_collection.rb'
require './Star_wars.rb'
require './2048.rb'
# require './Overcoming_obstacles.rb'

class Menu < Gosu::Window
    def initialize
        super(1200, 800)
        self.caption = 'Games Menu'
        @image_gems_collection = Gosu::Image.new('Media/Image_Gems_Collection.png')
        @image_star_war = Gosu::Image.new('Media/Image_Star_Wars.png')
        @image_2048 = Gosu::Image.new('Media/Image_2048.png')
        @song = Gosu::Song.new('Media/Song_Risk_Hasbro_Theme.wav')
        @font = Gosu::Font.new(30)
        @i = 0
        @j = false
    end

    def game1(mouse_x, mouse_y)
        if ((mouse_x > 310 and mouse_x < 550) && (mouse_y > 220 and mouse_y < 400))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def game2(mouse_x, mouse_y)
        if ((mouse_x > 650 and mouse_x < 890) && (mouse_y > 220 and mouse_y < 400))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def game3(mouse_x, mouse_y)
        if ((mouse_x > 310 and mouse_x < 550) && (mouse_y > 470 and mouse_y < 710))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def button_down(id)
        if (id == Gosu::MsLeft)
            if (game1(mouse_x, mouse_y))
                close
                GemsCollection.new.show
            elsif (game2(mouse_x, mouse_y))
                close
                StarWars.new.show
            elsif (game3(mouse_x, mouse_y))
                close
                Original2048.new.show
            elsif (id == Gosu::KbD)
                close
                OvercomingObstacles.new.show
            end
        end
    end

    def draw
        @song.play(true)
        if game1(mouse_x, mouse_y)
            Gosu.draw_rect(300, 210, 260, 200, Gosu::Color::CYAN, 0)
        elsif game2(mouse_x, mouse_y)
            Gosu.draw_rect(640, 210, 260, 200, Gosu::Color::YELLOW, 0)
        elsif game3(mouse_x, mouse_y)
            Gosu.draw_rect(300, 460, 260, 260, Gosu::Color.argb(0xff_ff3366), 0)
        end
        @image_gems_collection.draw(310, 220, 0, 0.6, 0.6)
        @image_star_war.draw(650, 220, 0, 0.6, 0.6)
        @image_2048.draw(310, 470, 0, 0.6, 0.6)
        @font.draw('WELCOME TO', 32, 38, 0, 2.1, 2.1, Gosu::Color::FUCHSIA)
        @font.draw('GAMES MENU', 445, 8, 0, 4.0, 4.0, Gosu::Color::GREEN)
        @font.draw('(By BLOOD MOON)', 525, 145, 0, 0.9, 0.9, Gosu::Color::RED)
        @font.draw('Gems Collection', 350, 420, 0, 0.8, 0.8, Gosu::Color.argb(0xff_996600))
        @font.draw('Star Wars', 724, 420, 0, 0.8, 0.8, Gosu::Color.argb(0xff_0000aa))
        @font.draw('2048', 408, 730, 0, 0.8, 0.8, Gosu::Color.argb(0xff_00ccff))
        @font.draw('Left-click to choose your favorite game...', 480, 775, 0, 0.5, 0.5, Gosu::Color::WHITE)
    end
end

Menu.new.show

