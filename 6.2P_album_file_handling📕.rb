# By MOON

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :title, :artist, :genre

	def initialize (title, artist, genre)
        @title = title
        @artist = artist
		@genre = genre
	end
end

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

def read_tracks(music_file)
	count = music_file.gets().to_i()
    tracks = []
    i = 0
    while (i < (count * 2)) do
        i += 1
        tracks[i] = music_file.gets()
    end
	return tracks
end

def print_tracks(tracks)
	i = 0
    while (i < tracks.length) do
        i += 1
        if (i<tracks.length)
            puts(tracks[i])        
        else
            print(tracks[i])
        end
    end
end

def read_album(music_file)
    album_artist = music_file.gets()
    album_title = music_file.gets()
    album_genre = music_file.gets().to_i
	album = Album.new(album_title, album_artist, album_genre,)
	return album
end

def print_album(album)
    puts(album.artist)
    puts(album.title)
	puts('Genre is ' + album.genre.to_s)
	puts($genre_names[album.genre])
end

def main()
	music_file = File.new("Texts/6.2_album.txt", "r")
	album = read_album(music_file)
    tracks = read_tracks(music_file)
	music_file.close()
	print_album(album)
    print_tracks(tracks)
end

main()
