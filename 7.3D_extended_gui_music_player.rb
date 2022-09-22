# By BLOODMOON

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

def read_albums(file)
	count = file.gets.chomp.to_i
	albums = Array.new
	while (count > 0)
		album = read_album(file)
    	albums << album
    	count -= 1
  	end
	return albums
end

class MusicPlayerMain < Gosu::Window

	def initialize
	    super(800, 600)
	    self.caption = "Music Player"
        @images = []
        @font = Gosu::Font.new(20)
        @songs = Array.new()
        for i in 1..($albums.length)
            @songs[i] = Array.new()
        end
        @display = false
        @play_album = @play_track = 0
        for i in 1..($albums.length)
            @images[i] = Gosu::Image.new($albums[i - 1].address.chomp)
        end
        for i in 1..($albums.length)
            for j in 1..($albums[i - 1].tracks.length)
                @songs[i][j] = Gosu::Song.new($albums[i - 1].tracks[j - 1].location.chomp)
            end
        end
	end

    def play_album(mouse_x, mouse_y, count)
        play = 0
        while (count > 0)
            play = ($albums.length - count + 1) if ((mouse_x > 395) && (mouse_x < 750) && (mouse_y > (255 - 40 * count)) && (mouse_y < (278 - 40 * count)))
            count -= 1
        end
        return play
    end

    def play_track(mouse_x, mouse_y, k)
        play = 0
        play = k if ((mouse_x > 440) && (mouse_x < 600) && (mouse_y > (360 + 40 * (k - 1))) && (mouse_y < (380 + 40 * (k - 1))))
        return play
    end

	def update
	end

	def draw
		draw_quad(0, 0, TOP_COLOR, 800, 0, TOP_COLOR, 0, 600, TOP_COLOR, 800, 600, TOP_COLOR, 0)
        draw_quad(10, 10, BOTTOM_COLOR, 790, 10, BOTTOM_COLOR, 10, 590, BOTTOM_COLOR, 790, 590, BOTTOM_COLOR, 0)
        Gosu.draw_rect(30, 40, 320, 245, Gosu::Color::GRAY, 0)
        Gosu.draw_rect(40, 50, 300, 225, Gosu::Color::GRAY, 0)
        @font.draw('Albums', 450, 30, 1, 1.8, 1.8, Gosu::Color::BLACK)
        @font.draw('Tracks', 450, 300, 1, 1.5, 1.5, Gosu::Color::BLACK) if (@play != 0)
        count = $albums.length
        while (count > 0)
            @font.draw('*', 370, (260 - 40 * count), 1, 1.2, 1.2, Gosu::Color::WHITE)
            @font.draw("#{$albums[$albums.length - count].title.chomp} of #{$albums[$albums.length - count].artist.chomp}", 395, (255 - 40 * count), 1, 1.2, 1.2, Gosu::Color::WHITE)               
            count -= 1
        end
        for i in 1..($albums.length)
            if (@play_album == i)
                @images[i].draw(40, 50, 1, 0.3, 0.3)
                j = $albums.length - i + 1
                @font.draw('*', 360, (245 - 40 * j), 1, 4.0, 4.0, Gosu::Color::YELLOW)
                @font.draw("#{$albums[$albums.length - j].title.chomp} of #{$albums[$albums.length - j].artist.chomp}", 395, (255 - 40 * j), 1, 1.2, 1.2, Gosu::Color::YELLOW)
                k = 0
                while (k < $albums[i - 1].tracks.length)
                    @font.draw('.', 410, (325 + 40 * k), 1, 3.0, 3.0)
                    @font.draw($albums[i - 1].tracks[k].name, 440, (360 + 40 * k), 1, 1.0, 1.0)               
                    k += 1
                end
                for k in 1..($albums[i - 1].tracks.length)
                    if (@play_track == k)
                        @font.draw('.', 405, (295 + 40 * (k - 1)), 1, 5.0, 5.0, Gosu::Color::GREEN)
                        @font.draw($albums[i - 1].tracks[k - 1].name, 440, (360 + 40 * (k - 1)), 1, 1.0, 1.0, Gosu::Color::GREEN)   
                        @songs[i][k].play(true)   
                    end
                end        
            end    
        end
	end

	def button_down(id)
		if (id == Gosu::MsLeft)
            for i in 1..($albums.length)
                if (play_album(mouse_x, mouse_y, $albums.length) == i)
                    @play_album = i 
                    @play_track = 0
                end
            end
            if (@play_album != 0)
                for k in 1..($albums[@play_album - 1].tracks.length)
                    @play_track = k if (play_track(mouse_x, mouse_y, k) == k)
                end
            end
	    end
	end

end

def main
    $albums = nil
    filename = read_string("\nEnter filename: ")
	file = File.new(filename, "r")
    $albums = read_albums(file)
    file.close()
    if ($albums != nil)
        puts "\nThe albums have been loaded."
        puts("Press ENTER to contiue..")
    end
    string = read_string("")
    MusicPlayerMain.new.show if (string == "")      
end

main