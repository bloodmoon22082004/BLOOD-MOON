# By BLOODMOON

require 'gosu'

class GameWindow < Gosu::Window

    def initialize
        super 200, 200, false
        self.caption = "Map Creation"
        @array = Array.new(11) { Array.new(11) { 0 } }
        i = 0
        while (i < 10)
            j = 0
            while (j < 10)
                puts("Cell x: " + i.to_s + ", y: " + j.to_s + " north: " + check_top(i, j).to_s + " south: " + check_bottom(i, j).to_s + " east: " + check_right(i, j).to_s + " west: " + check_left(i, j).to_s)
                j += 1
            end
            puts("---------- End of Column ----------")
            i += 1
        end
    end
    
    def check_left(i, j)
        check_x = i - 1
        if (check_x < 0)
            check = 0
        else
            check = 1
        end
        return check
    end

    def check_right(i, j)
        check_x = i + 1
        if (check_x > 9)
            check = 0
        else
            check = 1
        end
        return check
    end

    def check_top(i, j)
        check_y = j - 1
        if (check_y < 0)
            check = 0
        else
            check = 1
        end
        return check
    end

    def check_bottom(i, j)
        check_y = j + 1
        if (check_y > 9)
            check = 0
        else
            check = 1
        end
        return check
    end

    def button_down(id)
        if (id == Gosu::MsLeft)
            i = 0
            while (i < 10)
                j = 0
                while (j < 10)
                    k = i * 20 + 10
                    l = j * 20 + 10
                    if (Gosu.distance(mouse_x, mouse_y, k, l) <= 10) 
                        @array[i][j] = 1
                    end        
                    j += 1
                end
                i += 1
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
                elsif (@array[i][j] == 1)
                    draw_quad(k, l, Gosu::Color::YELLOW, (k+20), l, Gosu::Color::YELLOW, k, (l+20), Gosu::Color::YELLOW, (k+20), (l+20), Gosu::Color::YELLOW, 0)
                end
                j += 1
            end
            i += 1
        end
    end
end

window = GameWindow.new
window.show
