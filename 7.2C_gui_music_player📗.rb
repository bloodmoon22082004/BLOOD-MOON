# By MOON

require 'gosu'
require './input_functions.rb'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)
MUSIC_COLOR = Gosu::Color.new(0xFFfa1e1e)

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :title, :artist, :address, :tracks

	def initialize(title, artist, address, tracks)
		@title = title
		@artist = artist
        @address = address
		@tracks = tracks
	end
end

class Track
  	attr_accessor :name, :location

  	def initialize(name, location)
    	@name = name
    	@location = location
  	end
end

def read_track(file)
	name = file.gets
	location = file.gets
	track = Track.new(name, location)
	return track
end

def read_tracks(file)
	count = file.gets.chomp.to_i
	tracks = Array.new()
	while (count > 0)
		track = read_track(file)
		tracks << track
		count -= 1
	end
	return tracks
end

def read_album(file)
	title = file.gets
	artist = file.gets
    address = file.gets
	tracks = read_tracks(file)
	album = Album.new(title, artist, address, tracks)
	return album
end

class MusicPlayerMain < Gosu::Window

	def initialize
	    super(800, 600)
	    self.caption = "Music Player"
        @image = Gosu::Image.new($album.address.chomp)
        @font = Gosu::Font.new(20)
        @songs = Array.new()
        @display = false
        @play = 0
        for i in 1..($album.tracks.length)
            @songs[i] = Gosu::Song.new($album.tracks[i - 1].location.chomp)
        end
	end

    def display_tracks(mouse_x, mouse_y)
        bool = false
        bool = true if (mouse_x > 40) && (mouse_x < 340) && (mouse_y > 90) && (mouse_y < 315)
        return bool
    end

    def play(mouse_x, mouse_y, count)
        play = 0
        while (count > 0)
            play = ($album.tracks.length - count + 1) if ((mouse_x > 422) && (mouse_x < 600) && (mouse_y > (315 - 40 * count)) && (mouse_y < (335 - 40 * count)))
            count -= 1
        end
        return play
    end

	def update
	end

	def draw
		draw_quad(0, 0, TOP_COLOR, 800, 0, TOP_COLOR, 0, 600, TOP_COLOR, 800, 600, TOP_COLOR, 0)
        draw_quad(10, 10, BOTTOM_COLOR, 790, 10, BOTTOM_COLOR, 10, 590, BOTTOM_COLOR, 790, 590, BOTTOM_COLOR, 0)
        @image.draw(40, 90, 1, 0.3, 0.3)
        @font.draw($album.artist, 115, 330, 1, 2.0, 2.0, Gosu::Color.argb(0xff_fa721e))
        if @display
            @font.draw("The #{$album.title.chomp} album", 475, 45, 1, 2.0, 2.0, Gosu::Color::BLACK)
            count = $album.tracks.length
            while (count > 0)
                @font.draw('*', 390, (320 - 40 * count), 1, 1.2, 1.2)
                @font.draw($album.tracks[$album.tracks.length - count].name, 422, (315 - 40 * count), 1, 1.2, 1.2)               
                count -= 1
            end
        end
        for i in 1..($album.tracks.length)
            if (@play == i)
                @songs[i].play(true) 
                j = $album.tracks.length - i + 1
                @font.draw('*', 380, (305 - 40 * j), 1, 4.0, 4.0, Gosu::Color::GREEN)
                @font.draw($album.tracks[$album.tracks.length - j].name, 422, (315 - 40 * j), 1, 1.2, 1.2, Gosu::Color::GREEN)    
            end    
        end
	end

	def button_down(id)
		case id
	    	when Gosu::MsLeft
                @display = true if (display_tracks(mouse_x, mouse_y))
                count = $album.tracks.length
                for i in 1..count
                    @play = i if (play(mouse_x, mouse_y, count) == i)
                end
	    end
	end

end

def main
    $album = nil
    filename = read_string("\nEnter filename: ")
	file = File.new(filename, "r")
    $album = read_album(file)
    file.close()
    if ($album != nil)
        puts "\nThe albums have been loaded."
        puts("Press ENTER to contiue..")
    end
    string = read_string("")
    MusicPlayerMain.new.show if (string == "")      
end

main
