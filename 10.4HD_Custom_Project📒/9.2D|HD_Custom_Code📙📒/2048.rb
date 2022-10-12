require 'gosu'

class Original2048 < Gosu::Window
    attr_accessor :records, :playing_count

    def initialize(records, playing_count)
        super(800, 800)
        self.caption = '2048'

        @start_image = Gosu::Image.new('Media/Image_Sky.png')
        @instruction_image = Gosu::Image.new('Media/Image_Question.png')
        @easy_image = Gosu::Image.new('Media/Image_Easy_Button.png')
        @hard_image = Gosu::Image.new('Media/Image_Hard_Button.png')
        @superhard_image = Gosu::Image.new('Media/Image_Super_hard_Button.png')
        @game_image = Gosu::Image.new('Media/Image_Night_Sky_with_Moon.jpg')
        @end_image = Gosu::Image.new('Media/Image_Night_Sky.jpg')
        @image_mp_2 = Gosu::Image.new('Media/Image_Mouse_pointer_2.png')
        @image_mp_3 = Gosu::Image.new('Media/Image_Mouse_pointer_3.png')
        @no2_image = Gosu::Image.new('Media/Image_2_Square.png')
        @no4_image = Gosu::Image.new('Media/Image_4_Square.png')
        @no8_image = Gosu::Image.new('Media/Image_8_Square.png')
        @no16_image = Gosu::Image.new('Media/Image_16_Square.png')
        @no32_image = Gosu::Image.new('Media/Image_32_Square.png')
        @no64_image = Gosu::Image.new('Media/Image_64_Square.png')
        @no128_image = Gosu::Image.new('Media/Image_128_Square.png')
        @no256_image = Gosu::Image.new('Media/Image_256_Square.png')
        @no512_image = Gosu::Image.new('Media/Image_512_Square.png')
        @no1024_image = Gosu::Image.new('Media/Image_1024_Square.png')
        @no2048_image = Gosu::Image.new('Media/Image_2048_Square.png')
        @start_song = Gosu::Song.new('Media/Song_2048_Starlight.wav')
        @level_1_song = Gosu::Song.new('Media/Song_2048_Sunrise.wav')
        @level_2_song = Gosu::Song.new('Media/Song_GD_Back_on_track.wav')
        @level_3_song = Gosu::Song.new('Media/Song_GD_Nock_em.wav')
        @end_song = Gosu::Song.new('Media/Song_2048_Twilight.wav')
        @collect_sound = Gosu::Sample.new('Media/Sound_Collecting.wav')
        @font = Gosu::Font.new(30)
        
        @screen = @start_time = @time_left = @bonus_time = @true_time = @time = @score = @level = 0
        @i = @j = @k = @t = @instruction_y = @instruction_y_index = 0
        @images = Array.new(17)

        @count_index = 0
        @records = records
        @playing_count = playing_count
    end

    def continue(images)
        bool = false
        j = 0
        for i in 1..16 
            j += 1 if (images[i] == 0)
        end
        bool = true if (j != 0) 
        return bool
    end

    def left(images, j, k)
        index = j
        while (index < k)
            index_1 = index + 1
            if (images[index] != 0)
                if (index >= j) && (index < k)
                    while (images[index_1] == 0 ) && (index_1 <= k)
                        index_1 += 1
                    end          
                    if (images[index] == images[index_1]) && (index_1 <= k)
                        @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                        @collect_sound.play(0.3)
                        images[index] *= 2
                        images[index_1] = 0
                    end
                end
            end
            index += 1
        end
        index = j
        while (index < k) do
            sum = 0
            for i in index..k
                sum += images[i]
            end
            if (sum != 0) 
                while (images[index] == 0) do
                    for i in index..k
                        images[i] = images[i + 1]
                    end
                    images[k] = 0
                end
            end
            index += 1 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def right(images, j, k)
        index = k
        while (index > j)
            index_1 = index - 1
            if (images[index] != 0)
                if (index > j) && (index <= k)
                    while (images[index_1] == 0 ) && (index_1 >= j)
                        index_1 -= 1
                    end          
                    if (images[index] == images[index_1]) && (index_1 >= j)
                        @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                        @collect_sound.play(0.3)
                        images[index] *= 2
                        images[index_1] = 0
                    end
                end
            end
            index -= 1
        end
        index = k
        while (index > j) do
            sum = 0
            for i in j..index
                sum += images[i]
            end
            if (sum != 0) 
                while (images[index] == 0) do
                    i = index
                    while (i >= j) do
                        images[i] = images[i - 1]
                        i -= 1
                    end
                    images[j] = 0
                end
            end
            index -= 1 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def up(images, j, k)
        index = j
        while (index < k)
            index_1 = index + 4
            if (images[index] != 0)
                while (images[index_1] == 0) && (index_1 <= k)
                    index_1 += 4
                    end
                if (images[index] == images[index_1]) && (index_1 <= k)
                    @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                    @collect_sound.play(0.3)
                    images[index] *= 2
                    images[index_1] = 0
                end
            end
            index += 4
        end
        index = j
        while (index < k)
            sum = 0
            i = index
            while (i <= k)
                sum += images[i]
                i += 4
            end
            if (sum != 0)
                while (images[index] == 0)
                    i = index
                    while (i <= k)
                        images[i] = images[i + 4]
                        i += 4
                    end
                    images[k] = 0
                end
            end
            index += 4 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def down(images, j, k)
        index = k
        while (index > j)
            index_1 = index - 4
            if (images[index] != 0)
                while (images[index_1] == 0) && (index_1 >= j)
                    index_1 -= 4
                    end
                if (images[index] == images[index_1]) && (index_1 >= j)
                    @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                    @collect_sound.play(0.3)
                    images[index] *= 2
                    images[index_1] = 0
                end
            end
            index -= 4
        end
        index = k
        while (index > j)
            sum = 0
            i = index
            while (i >= j)
                sum += images[i]
                i -= 4
            end
            if (sum != 0)
                while (images[index] == 0)
                    i = index
                    while (i >= j)
                        images[i] = images[i - 4]
                        i -= 4
                    end
                    images[j] = 0
                end
            end
            index -= 4 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def drawing(value, index_1, index_2)
        case value
            when 2
                @no2_image.draw_rot(index_1, index_2, 0)
            when 4
                @no4_image.draw_rot(index_1, index_2, 0)
            when 8
                @no8_image.draw_rot(index_1, index_2, 0)
            when 16
                @no16_image.draw_rot(index_1, index_2, 0)
            when 32
                @no32_image.draw_rot(index_1, index_2, 0)
            when 64
                @no64_image.draw_rot(index_1, index_2, 0)
            when 128
                @no128_image.draw_rot(index_1, index_2, 0)
            when 256
                @no256_image.draw_rot(index_1, index_2, 0)
            when 512
                @no512_image.draw_rot(index_1, index_2, 0)
            when 1024
                @no1024_image.draw_rot(index_1, index_2, 0)
            when 2048
                @no2048_image.draw_rot(index_1, index_2, 0)
        end
    end

    def score(images)
        max = images[1]
        for i in 2..16 
            max = images[i] if (images[i] > max)
        end
        return max
    end

    def gameover(images)
        bool = false
        @j = 0
        for i in 1..16
            @j += 1 if (images[i] == 0)
        end
        if (@j == 0)
            images_1 = []
            @k = 0
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = left(images_1, 1, 4)
            images_1 = left(images_1, 5, 8)
            images_1 = left(images_1, 9, 12)
            images_1 = left(images_1, 13, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = right(images_1, 1, 4)
            images_1 = right(images_1, 5, 8)
            images_1 = right(images_1, 9, 12)
            images_1 = right(images_1, 13, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = up(images_1, 1, 13)
            images_1 = up(images_1, 2, 14)
            images_1 = up(images_1, 3, 15)
            images_1 = up(images_1, 4, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = down(images_1, 1, 13)
            images_1 = down(images_1, 2, 14)
            images_1 = down(images_1, 3, 15)
            images_1 = down(images_1, 4, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            bool = true if (@k == 4)
        end
        return bool
    end

    def easy_click(mouse_x, mouse_y)
        if ((mouse_x > 150 and mouse_x < 300) && (mouse_y > 415 and mouse_y < 470))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def hard_click(mouse_x, mouse_y)
        if ((mouse_x > 500 and mouse_x < 650) and (mouse_y > 415 and mouse_y < 470))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def superhard_click(mouse_x, mouse_y)
        if ((mouse_x > 250 and mouse_x < 550) and (mouse_y > 540 and mouse_y < 650))
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
                @instruction_y = 300
                @instruction_y_index = 0
            elsif (id == Gosu::MsLeft)
                if (easy_click(mouse_x, mouse_y)) || (hard_click(mouse_x, mouse_y)) || (superhard_click(mouse_x, mouse_y))
                    if easy_click(mouse_x, mouse_y)
                        @time = 180
                        @level = 1
                    elsif hard_click(mouse_x, mouse_y)
                        @time = 90
                        @level = 2
                    elsif superhard_click(mouse_x, mouse_y)
                        @time = 45
                        @level = 3
                    end
                    @screen = 1
                    @bonus_time = 0
                    @start_time = Gosu.milliseconds
                    @true_time
                    @i = 1
                    while (@i <= 16)
                        @images[@i] = 0
                        @i += 1
                    end
                    @i = 0
                    while (@i == 0)
                        @j = rand(1..16)
                        if (@images[@j] == 0)
                            @images[@j] = 2
                            @i = 1
                        end
                    end
                end
            end
        elsif (@screen == 1)
            if (id == Gosu::KbLeft) || (id == Gosu::KbA)
                @images = left(@images, 1, 4)
                @images = left(@images, 5, 8)
                @images = left(@images, 9, 12)
                @images = left(@images, 13, 16)

                if (continue(@images))
                    @i = 0
                    while (@i == 0)
                        @j = rand(1..16)
                        if (@images[@j] == 0)
                            @images[@j] = 2
                            @i = 1
                        end
                    end
                end

                @screen = 2 if gameover(@images)
            elsif (id == Gosu::KbRight) || (id == Gosu::KbD)
                @images = right(@images, 1, 4)
                @images = right(@images, 5, 8)
                @images = right(@images, 9, 12)
                @images = right(@images, 13, 16)

                if (continue(@images))
                    @i = 0
                    while (@i == 0)
                        @j = rand(1..16)
                        if (@images[@j] == 0)
                            @images[@j] = 2
                            @i = 1
                        end
                    end
                end

                @screen = 2 if gameover(@images)
            elsif (id == Gosu::KbUp) || (id == Gosu::KbW)
                @images = up(@images, 1, 13)
                @images = up(@images, 2, 14)
                @images = up(@images, 3, 15)
                @images = up(@images, 4, 16)

                if (continue(@images))
                    @i = 0
                    while (@i == 0)
                        @j = rand(1..16)
                        if (@images[@j] == 0)
                            @images[@j] = 2
                            @i = 1
                        end
                    end
                end

                @screen = 2 if gameover(@images)
            elsif (id == Gosu::KbDown) || (id == Gosu::KbS)
                @images = down(@images, 1, 13)
                @images = down(@images, 2, 14)
                @images = down(@images, 3, 15)
                @images = down(@images, 4, 16)

                if (continue(@images))
                    @i = 0
                    while (@i == 0)
                        @j = rand(1..16)
                        if (@images[@j] == 0)
                            @images[@j] = 2
                            @i = 1
                        end
                    end
                end

                @screen = 2 if gameover(@images)
            end
        end
        if (id == Gosu::KbK) && (@screen != 0)
            @screen = 0
            @level = 0

            @count_index = 0
        elsif (id == Gosu::KbEscape)
            close
            window = Menu.new(1, @records, @playing_count)
            window.show
        end
    end

    def update
        if (@screen == 1)
            @true_time = (Gosu.milliseconds - @start_time) / 1000
            @time_left = (@time - ((Gosu.milliseconds - @start_time) / 1000) + @bonus_time)
            @t = (@time - ((Gosu.milliseconds - @start_time) / 1000) + @bonus_time)
        elsif (@screen == 2)
            @t = (@time - ((Gosu.milliseconds - @start_time) / 1000) + @bonus_time)
        end
    end

    def draw
        if (@screen == 0)
            @start_image.draw(0, 0, 0)
            @start_song.play(true)
            @font.draw('WELCOME', 26, 60, 0, 2.0, 2.0, Gosu::Color::GREEN)
            @font.draw('TO', 320, 60, 0, 2.0, 2.0, Gosu::Color.argb(0xff_118833))
            @font.draw('THE 2048', 418, 35, 0, 3.0, 3.0, Gosu::Color.argb(0xff_ff00ff))
            @font.draw('<i>(By BLOODMOON)</i>', 254, 168, 0, 1.4, 1.4, Gosu::Color::RED)
            @font.draw('<i>Use the Mouse to choose the level and begin...</i>', 220, 322, 0, 0.7, 0.7, Gosu::Color::BLACK)
            @font.draw('<i>Press J key for Instruction.</i>', 300, 745, 0, 0.7, 0.7, Gosu::Color::YELLOW)
            if easy_click(mouse_x, mouse_y)
                Gosu.draw_rect(145, 410, 160, 65, Gosu::Color::YELLOW, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            elsif hard_click(mouse_x, mouse_y)
                Gosu.draw_rect(495, 410, 160, 65, Gosu::Color::YELLOW, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            elsif superhard_click(mouse_x, mouse_y)
                Gosu.draw_rect(240, 530, 320, 130, Gosu::Color::YELLOW, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            else
                @image_mp_2.draw(mouse_x, mouse_y, 1) if (mouse_y >= 0)
            end
            @easy_image.draw(150, 415, 0)
            @hard_image.draw(500, 415, 0)
            @superhard_image.draw(250, 540, 0, 2.0, 2.0)
        elsif (@screen == -1)
            @instruction_image.draw(0, 0, 1)
            Gosu.draw_rect(0, 264, 800, 26, Gosu::Color::BLACK, 1)
            if (@instruction_y >= -420)
                @instruction_y_index += 1
                @instruction_y_index = 0 if (@instruction_y_index == 50000)
                @instruction_y -= 1 if ((@instruction_y_index % 5) == 1)
            else
                @instruction_y = 420
                @instruction_y_index = 0 if (@instruction_y_index == 50000)
            end
            @font.draw(' -   Use the Left, Right, Up and Down arrow keys (or A, D, W', 15, @instruction_y + 330, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw('and S keys respectively) to move the tiles.', 15, @instruction_y + 380, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw(' -   Tiles with the same number merge into one when they touch.', 15, @instruction_y + 430, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw('Add them up to reach 2048!', 15, @instruction_y + 480, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw(' -   When you reach tiles with the number greater than or equal', 15, @instruction_y + 530, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw('to 32, you will get bonus time!!', 15, @instruction_y + 580, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw(' -   At any time, press K key to return to the 2048 Menu, or', 15, @instruction_y + 630, 0, 1.0, 1.0, Gosu::Color::GRAY)
            @font.draw('Esc to the Main Menu.', 15, @instruction_y + 680, 0, 1.0, 1.0, Gosu::Color::GRAY)
            Gosu.draw_rect(0, 715, 800, 85, Gosu::Color::BLACK, 1)
            @font.draw('<i>Press K key to return to Menu.</i>', 260, 750, 1, 0.8, 0.8, Gosu::Color::WHITE)
        elsif (@screen == 1)
            case (@level)
                when 1
                    @level_1_song.play(true)
                when 2
                    @level_2_song.play(true)
                when 3
                    @level_3_song.play(true)
            end
            @game_image.draw(0, 0, 0)
            j = 0
            for i in 1..16
                if (i >= 1) && (i <= 4)
                    j = 150 * i + 25
                    k = 175
                    drawing(@images[i], j, k)
                elsif (i >= 5) && (i <= 8)
                    j = 150 * i - 575
                    k = 325
                    drawing(@images[i], j, k)
                elsif (i >= 9) && (i <= 12)
                    j = 150 * i - 1175
                    k = 475
                    drawing(@images[i], j, k)
                elsif (i >= 13) && (i <= 16)
                    j = 150 * i - 1775
                    k = 625
                    drawing(@images[i], j, k)
                end
            end
            if (@time_left >= 0)
                @font.draw('Remaining time: ' + @time_left.to_s, 20, 750, 0, 1.0, 1.0, Gosu::Color::RED)
            else
                @screen = 2
            end
            @score = score(@images)
            @font.draw('Your Max score: ' + @score.to_s, 530, 750, 0, 1.0, 1.0, Gosu::Color::RED)
            @screen = 2 if (score(@images) >= 2048)
        elsif (@screen == 2)
            @end_song.play(true)
            @end_image.draw(0, 0, 0)
            j = 0
            for i in 1..16
                if (i >= 1) && (i <= 4)
                    j = 150 * i + 25
                    k = 175
                    drawing(@images[i], j, k)
                elsif (i >= 5) && (i <= 8)
                    j = 150 * i - 575
                    k = 325
                    drawing(@images[i], j, k)
                elsif (i >= 9) && (i <= 12)
                    j = 150 * i - 1175
                    k = 475
                    drawing(@images[i], j, k)
                elsif (i >= 13) && (i <= 16)
                    j = 150 * i - 1775
                    k = 625
                    drawing(@images[i], j, k)
                end
            end
            @font.draw('Remaining time: ' + @time_left.to_s, 20, 750, 0, 1.0, 1.0, Gosu::Color::RED) if (@time_left >= 0)
            if ((@time_left - @t) >= 2)
                @end_image.draw(0, 0, 0)
                @font.draw('<b>GAME OVER!!</b>', 150, 130, 0, 3.0, 3.0, Gosu::Color::WHITE)
                @score = score(@images)
                if (@score >= 2048)
                    @font.draw('Congratulation, you reach ' + @score.to_s  + '! ', 220, 390, 0, 1.0, 1.0, Gosu::Color::GREEN)
                    if (@count_index == 0)
                        @records.push Record.new('            2048', @score, @true_time, 'Victory')
                        @count_index += 1
                        @playing_count += 1
                    end
                elsif (@time_left <= 0)
                    @font.draw('Time out, your max score is ' + @score.to_s, 218, 390, 0, 1.0, 1.0, Gosu::Color::GREEN)
                    if (@count_index == 0)
                        @records.push Record.new('            2048', @score, @true_time, 'Defeat')
                        @count_index += 1
                        @playing_count += 1
                    end
                else
                    @font.draw('Sorry, no way to continue, your max score is ' + @score.to_s, 112, 390, 0, 1.0, 1.0, Gosu::Color::GREEN)
                    if (@count_index == 0)
                        @records.push Record.new('            2048', @score, @true_time, 'Defeat')
                        @count_index += 1
                        @playing_count += 1
                    end
                end
                @font.draw('<i>Press K key to return to Menu or</i>', 200, 480, 0, 1.0, 1.0, Gosu::Color::YELLOW)
                @font.draw('<i>Escape key for another experience...</i>', 186, 545, 0, 1.0, 1.0, Gosu::Color::YELLOW)
            end
        end
    end
end

# Original2048.new.show