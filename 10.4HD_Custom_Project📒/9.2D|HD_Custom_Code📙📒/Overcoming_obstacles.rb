require 'gosu'

class Brick 
    attr_accessor :x, :space

    def initialize(window)
        @x = 1100
        @brick = Gosu::Image.new('Media/Image_Bricks.png')
        @space = rand(1..3)
    end

    def move(speed)
        @x -= speed
    end

    def draw
        for i in 0..5 do
            if (i != @space) && (i != (@space + 1))
                z = 0
            else
                z = -1
            end    
            @brick.draw(@x, (i * 80) - 20, z, 0.2, 0.2)
        end        
    end
end

class OvercomingObstacles < Gosu::Window
    attr_accessor :records, :playing_count

    def initialize(records, playing_count)
        super(1100, 540)
        self.caption = 'Overcoming Obstacles'

        # Set up variables for media (images, songs, sounds, fonts)
        @sky_background = Gosu::Image.new('Media/Image_Sky_and_Grass.jpg')
        @instruction_image = Gosu::Image.new('Media/Image_Question.png')
        @easy_image = Gosu::Image.new('Media/Image_Easy_Button.png')
        @hard_image = Gosu::Image.new('Media/Image_Hard_Button.png')
        @superhard_image = Gosu::Image.new('Media/Image_Super_hard_Button.png')
        @image_mp_2 = Gosu::Image.new('Media/Image_Mouse_pointer_2.png')
        @image_mp_3 = Gosu::Image.new('Media/Image_Mouse_pointer_3.png')
        @bird = Gosu::Image.load_tiles('Media/Image_Bird.png', 54, 50)
        @song_opening = Gosu::Song.new('Media/Song_GD_Clutterfunk.wav')
        @song_game_starting = Gosu::Song.new('Media/Song_GD_Stereo_Madness.wav')
        @song_level_1 = Gosu::Song.new('Media/Song_GD_Deadlocked.wav')
        @song_level_2 = Gosu::Song.new('Media/Song_GD_Base_after_base.wav')
        @song_level_3 = Gosu::Song.new('Media/Song_GD_Cant_let_go.wav')
        @song_ending = Gosu::Song.new('Media/Song_Chinese_Bamboo_flute.wav')
        @overpass_sound = Gosu::Sample.new('Media/Sound_Collecting.wav')
        @font = Gosu::Font.new(30)
        
        # Set up variables used for playing this game
        @bricks = []
        @screen = @screen_1 = 0
        @x0 = @x = @bird_y = @speed = @instruction_y = @instruction_y_index = 0
        @draw_bird = false
        @time = @time_1 = @start_time = 0
        @level = @score = @i = @speed_change = @jump = @first_brick_x = 0

        # Set up variables for recording process
        @count_index = 0
        @records = records
        @playing_count = playing_count
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

    def needs_cursor?
        false
    end
    
    def button_down(id)
        if (@screen == 0)
            if (id == Gosu::KbJ)
                @screen = -1
                @instruction_y = 150
                @instruction_y_index = 0
            elsif (id == Gosu::MsLeft)
                if (easy_click(mouse_x, mouse_y)) || (hard_click(mouse_x, mouse_y)) || (superhard_click(mouse_x, mouse_y))
                    if easy_click(mouse_x, mouse_y)
                        @speed = 3
                        @level = 1
                    elsif hard_click(mouse_x, mouse_y)
                        @speed = 6
                        @level = 2
                    elsif superhard_click(mouse_x, mouse_y)
                        @speed = 10
                        @level = 3
                    end
                    @screen = 1
                    @screen_1 = @x0 = @x = @speed_change = @first_brick_x = @time = @score = 0
                end
            end
        elsif (@screen == 1)
            if (id == Gosu::KbSpace)
                if (@screen_1 == 0)
                    @start_time = Gosu.milliseconds 
                    @first_brick_x = 1100
                end
                @screen_1 = @jump = 1
                @time_1 = @time
            end
        end
        if (id == Gosu::KbK) && (@screen != 0)
            @screen = 0
            @count_index = 0
            @screen_1 = 0
            @x0 = @x = @bird_y = @speed = 0
            @time = @time_1 = @start_time = 0
            @score = @i = @speed_change = @jump = @first_brick_x = 0
            @bricks.dup.each do |brick|
                @bricks.delete brick
            end
        elsif (id == Gosu::KbEscape)
            close
            Menu.new(1, @records, @playing_count).show
        end
    end

    def update
        if (@screen == 0)
            @x0 -= 1
        elsif (@screen == 1)
            if (@screen_1 == 0)
                @bird_y = 240
            elsif (@screen_1 == 1)
                @time = Gosu.milliseconds - @start_time
                @bird_y += 3
                if (@jump == 1) && ((@time - @time_1) <= 280)
                    @bird_y -= 6
                elsif ((@time - @time_1) > 280)
                    @jump = 0
                end
                if ((@first_brick_x % 275) >= 0) && ((@first_brick_x % 275) < @speed)
                    @bricks.push Brick.new(self)
                end
                @bricks.dup.each do |brick|
                    @bricks.delete brick if (brick.x <= -76)
                    if (brick.x <= 176) && (brick.x >= 47)
                        @screen = 2 if (((@bird_y - 20) < (brick.space * 80) - 20) || ((@bird_y + 20) >= (brick.space * 80) + 140))
                    elsif (brick.x < 47) && (brick.x >= (47 - @speed)) && (@screen == 1)
                        @score += (1 * @level)
                        @overpass_sound.play(0.4)
                    end
                end
                @bricks.each do |brick|
                    brick.move(@speed)
                end
                @first_brick_x -= @speed
            end
            @x -= @speed
            if (@time >= 12000) && (@time < 24000) && (@speed_change == 0)
                @speed += 1
                @speed_change += 1
            elsif (@time >= 24000) && (@time < 36000) && (@speed_change == 1)
                @speed += 1
                @speed_change += 1
            elsif (@time >= 36000) && (@time < 48000) && (@speed_change == 2)
                @speed += 1
                @speed_change += 1
            elsif (@time >= 48000) && (@time < 60000) && (@speed_change == 3)
                @speed += 1
                @speed_change += 1
            elsif (@time >= 60000) 
                @screen = 2
            end
            @screen = 2 if (@bird_y > 440)
        end
    end

    def draw
        if (@screen == 0)
            @song_opening.play(true)
            @sky_background.draw(@x0, 0, 0)
            @sky_background.draw(@x0 + 550, 0, 0)
            @sky_background.draw(@x0 + 1100, 0, 0)
            @x0 = 0 if (@x0 <= -550)
            @font.draw('WELCOME', 40, 20, 0, 3.0, 3.0, Gosu::Color.argb(0xff_2b1b63))
            @font.draw('TO ', 490, 20, 0, 3.0, 3.0, Gosu::Color.argb(0xff_15ebd5))
            @font.draw('<i> Overcoming Obstacles </i> ', 380, 140, 0, 2.4, 2.4, Gosu::Color.argb(0xff_d60202))
            @font.draw('<i>(By BLOODMOON)</i>', 425, 384, 0, 1.0, 1.0, Gosu::Color.argb(0xff_e6e600))
            @font.draw('<i>Left-click to choose the level and begin or</i>', 355, 460, 0, 0.7, 0.7, Gosu::Color::BLACK)
            @font.draw('<i>press J key for Instruction.</i>', 430, 490, 0, 0.7, 0.7, Gosu::Color::BLACK)
            if easy_click(mouse_x, mouse_y)
                Gosu.draw_rect(100, 270, 170, 75, Gosu::Color.argb(0xff_ffa526), 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            elsif hard_click(mouse_x, mouse_y)
                Gosu.draw_rect(460, 270, 170, 75, Gosu::Color.argb(0xff_ff26b3), 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            elsif superhard_click(mouse_x, mouse_y)
                Gosu.draw_rect(820, 270, 170, 75, Gosu::Color.argb(0xff_8bff26), 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            else
                @image_mp_2.draw(mouse_x, mouse_y, 1) if (mouse_y >= 0)
            end
            @easy_image.draw(110, 280, 0)
            @hard_image.draw(470, 280, 0)
            @superhard_image.draw(830, 280, 0)
        elsif (@screen == -1)
            @instruction_image.draw(0, 0, 1, 1.375, 1)
            if (@instruction_y >= -200)
                @instruction_y_index += 1
                @instruction_y_index = 0 if (@instruction_y_index == 50000)
                @instruction_y -= 1 if ((@instruction_y_index % 5) == 1)
            else
                @instruction_y = 200
                @instruction_y_index = 0 if (@instruction_y_index == 50000)
            end
            @font.draw('Press Space bar to jump up a distance, help the bird pass through the gap between the walls.', 80, @instruction_y + 260, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('The bird will be injured if it falls to the ground, or collides with an obstacle!!', 80, @instruction_y + 300, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('For each level, when you overcome each obstacle, you will receive a different score.', 80, @instruction_y + 340, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('You will win the game if you pass all the obstacles in 60 seconds.', 80, @instruction_y + 380, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('At any time, press K key to return to the OO Menu, or Esc to the Main Menu.', 80, @instruction_y + 420, 0, 0.6, 0.6, Gosu::Color::GRAY)
            Gosu.draw_rect(0, 480, 1100, 60, Gosu::Color::BLACK, 1)
            @font.draw('<i>Press K key to return to Menu.</i>', 380, 500, 1, 0.8, 0.8, Gosu::Color::WHITE)
        elsif (@screen == 1)
            @sky_background.draw(@x, 0, 0)
            @sky_background.draw(@x + 550, 0, 0)
            @sky_background.draw(@x + 1100, 0, 0)
            @x = 0 if (@x <= -550)   
            @font.draw('<i>Press Space to begin ...</i>', 450, 20, 0, 0.8, 0.8, Gosu::Color.argb(0xff_ff00ff)) if (@screen_1 == 0)
            if (@bird_y <= 440)
                if (@i < @bird.count)
                    @bird[@i].draw_rot(150, @bird_y, 0)
                    @i += 1
                else
                    @draw_bird = false
                    @i = 0
                end
                @draw_bird = true
            else
                @bird[@i].draw_rot(150, @bird_y, 0)
            end
            if (@screen_1 == 1)
                @bricks.each do |brick|
                    brick.draw
                end
                if (@level == 1)
                    @song_level_1.play(true)
                elsif (@level == 2)
                    @song_level_2.play(true)
                elsif (@level == 3)
                    @song_level_3.play(true)
                end
            else
                @song_game_starting.play(true)
            end
            @font.draw('Your Score: ' + @score.to_s, 10, 10, 0, 1.0, 1.0, Gosu::Color::RED)
            @font.draw('Time: ' + (@time / 1000).to_s, 20, 480, 0, 0.8, 0.8, Gosu::Color::RED)
            @font.draw('Speed: ' + @speed.to_s, 980, 480, 0, 0.8, 0.8, Gosu::Color::RED)
        elsif (@screen == 2)
            @song_ending.play(true)
            @sky_background.draw(@x, 0, 0)
            @sky_background.draw(@x + 550, 0, 0)
            @sky_background.draw(@x + 1100, 0, 0)
            @x = 0 if (@x <= -550)
            @bricks.each do |brick|
                brick.draw
            end
            @bird[@i].draw_rot(150, @bird_y, 0) if (@bird[@i] != nil)
            if ((Gosu.milliseconds - @start_time - @time) >= 500)
                @font.draw('<b>GAME OVER</b>', 345, 50, 0, 2.5, 2.5, Gosu::Color::BLACK)
                if ((Gosu.milliseconds - @start_time - @time) >= 750)
                    if (@time >= 60000)
                        @font.draw('How amazing! You have overcome all the obstacles!!', 200, 200, 0, 1.2, 1.2, Gosu::Color::BLACK)
                        
                        # Recording the result if you win
                        if (@count_index == 0)
                            @records.push Record.new('Overcoming Obstacles', @score, @time, 'Victory')
                            @count_index += 1
                            @playing_count += 1
                        end
                    else
                        @font.draw('What a pity, next time please be careful with the little bird!!', 150, 190, 0, 1.2, 1.2, Gosu::Color::BLACK)
                        
                        # Recording the result if you lose
                        if (@count_index == 0)
                            @records.push Record.new('Overcoming Obstacles', @score, (@time / 1000), 'Defeat ')
                            @count_index += 1
                            @playing_count += 1
                        end
                    end
                    @font.draw("You have overcome #{(@score / @level)} obstacles and got #{@score} scores!!!", 250, 280, 0, 1.0, 1.0, Gosu::Color::BLACK)
                    @font.draw('<i>Press K key to return to Menu or</i>', 380, 480, 0, 0.8, 0.8, Gosu::Color::RED)
                    @font.draw('<i>Escape key for another experience...</i>', 360, 515, 0, 0.8, 0.8, Gosu::Color::WHITE)
                end
            end
        end
    end
end

# OvercomingObstacles.new.show