# By BLOODMOON

require 'gosu'

class GameWindow < Gosu::Window

    def initialize
        super 200, 200, false
        self.caption = "Map Creation"
        @array = Array.new(11) { Array.new(11) { 0 } }
        @find = false
        @found = false
    end

    def check_gate(array)
        bool = bool_1 = bool_2 = false
        for j in 0..9 do
            bool_1 = true if (array[0][j] == 1) 
            bool_2 = true if (array[9][j] == 1)
        end
        bool = true if ((bool_1) && (bool_2))
        return bool
    end

    def check_nearby(array, i, j)
        index = 0
        index += 1 if (j > 0) && (array[i][j-1] == 1)
        index += 1 if (j < 9) && (array[i][j+1] == 1)
        index += 1 if (array[i+1][j] == 1)
        index += 1 if (array[i-1][j] == 1)
        return index
    end

    def change_valid(array)
        index = 0
        begin    
            for j in 0..9
                for i in 1..8
                    array[i][j] = 2 if (check_nearby(array, i, j) < 2) && (array[i][j] == 1)
                end
            end
            index += 1
        end until (index >= 100)
        return array      
    end

    def search(array, j_index)
        array_1 = Array.new(11) { Array.new(11) { 0 } }
        for i in 0..9
            for j in 0..9
                array_1[i][j] = array[i][j]
            end
        end
        array_1 = change_valid(array_1)
        if (array_1[1][j_index] == 1)
            array_1[0][j_index] = 1
            for j in 0..9
                if (j != j_index) && (array_1[0][j] == 1)
                    array_1[0][j] = 2
                    array_1 = change_valid(array_1)
                end
            end
            for j in 0..9
                if (array_1[9][j] == 1)
                    for j_1 in (j+1)..9
                        if (array_1[9][j_1] == 1)
                            array_1[9][j_1] = 2
                            array_1 = change_valid(array_1)
                        end
                    end
                end
            end
            for j in 0..9
                for i in 1..8
                    if (array_1[i][j] == 1) && (check_nearby(array_1, i, j) == 3)
                        if (check_nearby(array_1, i, j) == 3) && (array_1[i][j+1] == 1)
                            array_1[i][j+1] = 2
                        elsif (check_nearby(array_1, i, j) == 3) && (array_1[i][j-1] == 1)
                            array_1[i][j-1] = 2
                        elsif (check_nearby(array_1, i, j) == 3) && (array_1[i+1][j] == 1)
                            array_1[i+1][j] = 2
                        end
                        array_1 = change_valid(array_1)
                    end
                end
            end
            for j in 0..9
                for i in 0..9
                    array_1[i][j] = 3 if (array_1[i][j] == 1)
                end
            end
            for i in 0..9
                for j in 0..9
                    array[i][j] = array_1[i][j]
                end
            end
            @found = true
        end
        return array
    end    

    def button_down(id)
        if (id == Gosu::MsLeft) && (@find == false)
            i = 0
            while (i < 10)
                j = 0
                while (j < 10)
                    k = i * 20 + 10
                    l = j * 20 + 10
                    @array[i][j] = 1 if ((Gosu.distance(mouse_x, mouse_y, k, l) <= 10)  && (@array[i][j] == 0))
                    j += 1
                end
                i += 1
            end
        elsif (id == Gosu::MsRight) && (@found == false) && check_gate(@array)
            for j in 0..9 do
                i = 0
                k = i * 20 + 10
                l = j * 20 + 10
                if ((Gosu.distance(mouse_x, mouse_y, k, l) <= 10)  && (@array[i][j] == 1))
                    @array = search(@array, j)
                end
            end
        end
    end

    def update
    end
  
    def draw
        i = 0
        while (i < 10)
            j = 0
            while (j < 10)
                k = i * 20
                l = j * 20
                if (@array[i][j] == 0)
                    draw_quad(k, l, Gosu::Color::GREEN, (k+20), l, Gosu::Color::GREEN, k, (l+20), Gosu::Color::GREEN, (k+20), (l+20), Gosu::Color::GREEN, 0) 
                elsif (@array[i][j] == 1) || (@array[i][j] == 2)
                    draw_quad(k, l, Gosu::Color::YELLOW, (k+20), l, Gosu::Color::YELLOW, k, (l+20), Gosu::Color::YELLOW, (k+20), (l+20), Gosu::Color::YELLOW, 0)
                elsif (@array[i][j] == 3)
                    draw_quad(k, l, Gosu::Color::RED, (k+20), l, Gosu::Color::RED, k, (l+20), Gosu::Color::RED, (k+20), (l+20), Gosu::Color::RED, 0)
                end
                j += 1
            end
            i += 1
        end
    end
end

window = GameWindow.new
window.show