require 'gosu'

class GemsCollection < Gosu::Window
    def initialize
        super(800, 600)
        self.caption = 'Gems Collection'
        @gemmining = Gosu::Image.new('Media/Image_Gem_Mining.png')
        @question = Gosu::Image.new('Media/Image_Question.png')
        @underground = Gosu::Image.new('Media/Image_Underground.jpg')
        @emerald = Gosu::Image.new('Media/Image_Emerald.png')
        @ruby = Gosu::Image.new('Media/Image_Ruby.png')
        @sapphire = Gosu::Image.new('Media/Image_Sapphire.png')
        @danburite = Gosu::Image.new('Media/Image_Danburite.png')
        @amethyst = Gosu::Image.new('Media/Image_Amethyst.png')
        @hammer = Gosu::Image.new('Media/Image_Hammer.png')
        @rock = Gosu::Image.new('Media/Image_Rock.png')
        @font = Gosu::Font.new(30)
        @start_song = Gosu::Song.new('Media/Song_How_it_Begins.wav')
        @game_song = Gosu::Song.new('Media/Song_Mining_by_Moonlight.wav')
        @end_song = Gosu::Song.new('Media/Song_Chill.wav')
        @collect_sound = Gosu::Sample.new('Media/Sound_Collecting.wav')
        @wrong_sound = Gosu::Sample.new('Media/Sound_Wrong.wav')
        @x_0 = @x_1 = @x_2 = @x_3 = @x_4 = 400
        @y_0 = @y_1 = @y_2 = @y_3 = @y_4 = 300
        @x_5 = @y_5 = 16
        @x_6 = @y_6 = 116
        @x_7 = @y_7 = 216
        @x_8 = @y_8 = 316
        @x_9 = @y_9 = 416
        @x_10 = @y_10 = 516
        @v_x_0 = @v_y_0 = 1
        @v_x_1 = @v_y_1 = @v_x_6 = @v_y_6 = 3
        @v_x_2 = @v_y_2 = @v_x_8 = @v_y_8 = 5
        @v_x_3 = @v_y_3 = @v_x_10 = @v_y_10 = 7
        @v_x_4 = @v_y_4 = 15
        @v_x_5 = @v_y_5 = 2
        @v_x_7 = @v_y_7 = 4
        @v_x_9 = @v_y_9 = 6
        @visible_0 = @visible_1 = @visible_2 = @visible_3 = @visible_4 = @hit = @score = @start_time = 0
        @playing = 0
    end

    def button_down(id)
        if (@playing == 1)
            if (id == Gosu::MsLeft) || (id == Gosu::MsRight)
                if (Gosu.distance(mouse_x, mouse_y, @x_0, @y_0) < 50) && (@visible_0 >=0) && (Gosu.distance(mouse_x, mouse_y, @x_5, @y_5) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_6, @y_6) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_7, @y_7) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_8, @y_8) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_9, @y_9) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_10, @y_10) > 25)
                    @score += 1
                    @hit = 1
                elsif (Gosu.distance(mouse_x, mouse_y, @x_1, @y_1) < 50) && (@visible_1 >=0) && (Gosu.distance(mouse_x, mouse_y, @x_5, @y_5) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_6, @y_6) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_7, @y_7) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_8, @y_8) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_9, @y_9) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_10, @y_10) > 25)
                    @score += 3
                    @hit = 1
                elsif (Gosu.distance(mouse_x, mouse_y, @x_2, @y_2) < 50) && (@visible_2 >=0) && (Gosu.distance(mouse_x, mouse_y, @x_5, @y_5) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_6, @y_6) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_7, @y_7) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_8, @y_8) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_9, @y_9) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_10, @y_10) > 25)
                    @score += 5
                    @hit = 1
                elsif (Gosu.distance(mouse_x, mouse_y, @x_3, @y_3) < 50) && (@visible_3 >=0) && (Gosu.distance(mouse_x, mouse_y, @x_5, @y_5) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_6, @y_6) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_7, @y_7) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_8, @y_8) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_9, @y_9) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_10, @y_10) > 25)
                    @score += 7
                    @hit = 1
                elsif (Gosu.distance(mouse_x, mouse_y, @x_4, @y_4) < 60) && (@visible_4 >=0) && (Gosu.distance(mouse_x, mouse_y, @x_5, @y_5) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_6, @y_6) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_7, @y_7) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_8, @y_8) > 25)  && (Gosu.distance(mouse_x, mouse_y, @x_9, @y_9) > 25) && (Gosu.distance(mouse_x, mouse_y, @x_10, @y_10) > 25) && (@time <= 5)
                    @score += 15
                    @hit = 1
                else
                    @score -= 1
                    @hit = -1
                end
            end
        elsif (@playing == 0)
            if (id == Gosu::KbSpace)
                @playing = 1
                @score = @visible_0 = @visible_1 = @visible_2 = @visible_3 = @visible_4 = 0
                @start_time = Gosu.milliseconds
            elsif (id == Gosu::MsRight)
                @playing = -1
            end
        elsif (@playing == 2) || (@playing == -1)
            if (id == Gosu::KbSpace)
                @playing = 1
                @score = @visible_0 = @visible_1 = @visible_2 = @visible_3 = @visible_4 = 0
                @start_time = Gosu.milliseconds
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
        if (@playing == 1)
            @x_0 += @v_x_0
            @y_0 += @v_y_0
            @x_1 += @v_x_1
            @y_1 += @v_y_1
            @x_2 += @v_x_2
            @y_2 += @v_y_2
            @x_3 += @v_x_3
            @y_3 += @v_y_3
            @x_5 += @v_x_5
            @y_5 += @v_y_5
            @x_6 += @v_x_6
            @y_6 += @v_y_6
            @x_7 += @v_x_7
            @y_7 += @v_y_7
            @x_8 += @v_x_8
            @y_8 += @v_y_8
            @x_9 += @v_x_9
            @y_9 += @v_y_9
            @x_10 += @v_x_10
            @y_10 += @v_y_10
            if (((Gosu.milliseconds - @start_time) / 1000) >= 25)
                @x_4 += @v_x_4
                @y_4 += @v_y_4
                @v_x_4 *= -1 if (@x_4 - 50 > 700) || (@x_4 - 50 < 0)
                @v_y_4 *= -1 if (@y_4 - 49 > 502) || (@y_4 - 49 < 0)
                @visible_4 -= 1
                @visible_4 = 20 if (@visible_4 < -10)
            end
            @v_x_0 *= -1 if (@x_0 - 40 > 720) || (@x_0 - 40 < 0)
            @v_y_0 *= -1 if (@y_0 - 34 > 532) || (@y_0 - 34 < 0)
            @v_x_1 *= -1 if (@x_1 - 40 > 720) || (@x_1 - 40 < 0)
            @v_y_1 *= -1 if (@y_1 - 30 > 540) || (@y_1 - 30 < 0)
            @v_x_2 *= -1 if (@x_2 - 29 > 742) || (@x_2 - 29 < 0)
            @v_y_2 *= -1 if (@y_2 - 42 > 516) || (@y_2 - 42 < 0)
            @v_x_3 *= -1 if (@x_3 - 42 > 716) || (@x_3 - 42 < 0)
            @v_y_3 *= -1 if (@y_3 - 40 > 520) || (@y_3 - 40 < 0)
            @v_x_5 *= -1 if (@x_5 - 16 > 768) || (@x_5 - 16 < 0)
            @v_y_5 *= -1 if (@y_5 - 15 > 570) || (@y_5 - 15 < 0)
            @v_x_6 *= -1 if (@x_6 - 16 > 768) || (@x_6 - 16 < 0)
            @v_y_6 *= -1 if (@y_6 - 15 > 570) || (@y_6 - 15 < 0)
            @v_x_7 *= -1 if (@x_7 - 16 > 768) || (@x_7 - 16 < 0)
            @v_y_7 *= -1 if (@y_7 - 15 > 570) || (@y_7 - 15 < 0)
            @v_x_8 *= -1 if (@x_8 - 16 > 768) || (@x_8 - 16 < 0)
            @v_y_8 *= -1 if (@y_8 - 15 > 570) || (@y_8 - 15 < 0)
            @v_x_9 *= -1 if (@x_9 - 16 > 768) || (@x_9 - 16 < 0)
            @v_y_9 *= -1 if (@y_9 - 15 > 570) || (@y_9 - 15 < 0)
            @v_x_10 *= -1 if (@x_10 - 16 > 768) || (@x_10 - 16 < 0)
            @v_y_10 *= -1 if (@y_10 - 15 > 570) || (@y_10 - 15 < 0)
            @visible_0 -= 1
            @visible_1 -= 1
            @visible_2 -= 1
            @visible_3 -= 1
            @visible_0 = 20 if (@visible_0 < -10)
            @visible_1 = 20 if (@visible_1 < -10)
            @visible_2 = 20 if (@visible_2 < -10)
            @visible_3 = 20 if (@visible_3 < -10)
            @time = (30 - ((Gosu.milliseconds - @start_time) / 1000))
        end
    end

    def draw
        if (@playing == 0)
            @gemmining.draw(0, 0, 0)
            @start_song.play(true)
            @font.draw('Collecting', 200, 155, 0, 2.0, 2.0, Gosu::Color:: AQUA)
            @font.draw('GEMS!!!', 350, 230, 0, 2.6, 2.6, Gosu::Color:: FUCHSIA)
            @font.draw('(By BLOOD MOON)', 290, 330, 0, 1.0, 1.0, Gosu::Color::RED)
            @font.draw('Right-click for Instruction or', 280, 390, 0, 0.8, 0.8, Gosu::Color::GRAY)
            @font.draw('Press Space bar to begin...', 280, 420, 0, 0.8, 0.8, Gosu::Color::GRAY)
        elsif (@playing == -1)
            @question.draw(0, 0, 0)
            @font.draw('Click on the diffrent gems to get different numbers of point.', 15, 275, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('Clicking on the rocks, or on places other than gems will get 1 score minus.', 15, 300, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('Earn 80 scores in 30 seconds to win the game.', 15, 325, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('At any time, press K key to return to the Gem-collecting Menu, or Esc key to the Main Menu.', 15, 350, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @emerald.draw(40, 420, 0)
            @ruby.draw(180, 423, 0)
            @sapphire.draw(337, 410, 0)
            @danburite.draw(479, 415, 0)
            @amethyst.draw(650, 405, 0)
            @font.draw('for 1                   for 3                     for 5                     for 7                           for 15', 60, 515, 0, 0.7, 0.7, Gosu::Color::GRAY)
            @font.draw('(only in the last 5 seconds)', 620, 540, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('Press Space bar to begin...', 245, 560, 0, 1.0, 1.0, Gosu::Color::WHITE)
        elsif (@playing == 1)
            @game_song.play(true)
            @underground.draw(0, 0, 0)
            @font.draw('Your score: ' + @score.to_s + '/80', 20, 20, 0, 1.0, 1.0, Gosu::Color::WHITE)
            if (@time > 5)
                @font.draw('Remaining time: ' + @time.to_s, 20, 560, 0, 1.0, 1.0, Gosu::Color::FUCHSIA)
            else
                if (rand(1-100) < 30) && ((Gosu.milliseconds - @start_time) / 1000 >= 25)
                    @font.draw('Remaining time: ' + @time.to_s, 20, 560, 0, 1.0, 1.0, Gosu::Color::FUCHSIA)
                elsif ((Gosu.milliseconds - @start_time) / 1000 >= 30)
                    @playing = 2
                end
            end
            @playing = 2 if (@score >= 80)
            @emerald.draw(@x_0 - 40, @y_0 - 34, 0) if (@visible_0 >= 0)
            @ruby.draw(@x_1 - 40, @y_1 - 30, 0) if (@visible_1 >= 0)
            @sapphire.draw(@x_2 - 29, @y_2 - 42, 0) if (@visible_2 >= 0)
            @danburite.draw(@x_3 - 42, @y_3 - 40, 0) if (@visible_3 >= 0)
            if (@time <=5)
                @amethyst.draw(@x_4 - 50, @y_4 - 49, 0) if (@visible_4 >= 0)
            end
            @rock.draw(@x_5 - 16, @y_5 - 15, 0)
            @rock.draw(@x_6 - 16, @y_6 - 15, 0)
            @rock.draw(@x_7 - 16, @y_7 - 15, 0)
            @rock.draw(@x_8 - 16, @y_8 - 15, 0)
            @rock.draw(@x_9 - 16, @y_9 - 15, 0)
            @rock.draw(@x_10 - 16, @y_10 - 15, 0)
            @hammer.draw(mouse_x - 70, mouse_y - 25, 0)
            if (@hit == 0)
                c = Gosu::Color::NONE
            elsif (@hit == 1)
                c = Gosu::Color::GREEN
                @collect_sound.play
            elsif (@hit == -1)
                c = Gosu::Color::RED
                @wrong_sound.play(2.0)
            end
            draw_quad(0, 0, c, 800, 0, c, 0, 600, c, 800, 600, c, 0)
            @hit = 0
        elsif (@playing == 2)
            @end_song.play(true)
            draw_quad(0, 0, Gosu::Color::WHITE, 800, 0, Gosu::Color::WHITE, 0, 600, Gosu::Color::RED, 800, 600, Gosu::Color::RED, 0)
            @font.draw('GAME OVER.', 250, 100, 0, 1.8, 1.8, Gosu::Color::BLACK)
            if (@score >= 80)
                @font.draw('Congratulation, your score is ' + @score.to_s  + '! ', 220, 290, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw('Press Space bar to play again.'.to_s, 230, 380, 0, 1.0, 1.0, Gosu::Color::BLUE)
            else
                @font.draw('Time out, your score is ' + @score.to_s, 250, 290, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw('Press Space bar to try again :D'.to_s, 220, 380, 0, 1.0, 1.0, Gosu::Color::BLUE)
            end
        end
    end
end