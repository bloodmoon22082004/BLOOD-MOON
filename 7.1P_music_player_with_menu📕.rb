# By MOON

require './input_functions.rb'
  
$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :artist, :title, :year, :genre, :tracks

	def initialize(artist, title, year, genre, tracks)
		@artist = artist
		@title = title
		@year = year
		@genre = genre
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
	artist = file.gets
	title = file.gets
	year = file.gets
	genre = file.gets.to_i
	tracks = read_tracks(file)
	album = Album.new(artist, title, year, genre, tracks)

	return album
end

def read_albums()
	filename = read_string("\nEnter filename: ")
	file = File.new(filename, "r")
	count = file.gets.chomp.to_i
	albums = Array.new
	while (count > 0)
		album = read_album(file)
    	albums << album
    	count -= 1
  	end
	file.close()
	puts "\nThe albums have been loaded."
	read_string("Press ENTER to continue..\n")

	return albums
end

def display_track(track)
	puts("        " + track.name)
	puts("        " + track.location)
end

def display_tracks(tracks)
	count = tracks.length
	puts("    There are " + count.to_s + " tracks in the album")
	for i in 0..(count - 1)
		puts("      Track " + (i + 1).to_s + ": ")
		display_track(tracks[i])
	end
end

def display_album(album)
	puts("    Artist: " + album.artist)
	puts("    Title: " + album.title)
	puts("    Year: " + album.year)
	puts("    Genre: " + album.genre.to_s)
	display_tracks(album.tracks)
end

def display_albums(albums)
	count = albums.length()
	for i in 0..(count - 1)
		puts("\n  Album ID: " + (i + 1).to_s)
		display_album(albums[i])
		puts(" ")
	end
	read_string(" Press ENTER to continue..\n")
end

def display_by_genre(albums)
    count = albums.length()
    puts("\n Select genre")
    puts(" 1. Pop")
    puts(" 2. Classic")
    puts(" 3. Jazz")
    puts(" 4. Rock\n")
	puts(" ")
    genre = read_integer_in_range("\n  Please enter your choice:", 1, 4)
    genre = genre.to_i

    j = 0
    for i in 0..(count - 1)
        if (genre == albums[i].genre)
            puts("\n  Album ID: " + (i + 1).to_s)
            display_album(albums[i])
            puts(" ")
            j += 1
        end
    end
    if (j == 0)
        puts("  There is no any " + $genre_names[genre] + " albums.") 
    end
	read_string(" Press ENTER to continue..\n")
end

def display(albums)
	if (!albums)
		puts("You need to import albums first !!")
		puts(" ")
		return
	end
	puts(" ")
	puts(" What do you want to display?")
	puts(" 1. Display all albums")
	puts(" 2. Display albums by genre")
	count = read_integer_in_range(" Please enter your choice:", 1, 2)
	case count
		when 1 
			display_albums(albums)
		when 2			
            display_by_genre(albums)
		else
	end
end

def play(albums)
	if (!albums)
		puts("You need to import albums first !!")
		puts(" ")
		return
	end
	puts(" ")
	count = read_integer_in_range(" Enter your album ID: ", 1, (albums.length()))
	for i in 1..(albums.length())
		if (i == count)
			tracks = albums[i - 1].tracks
			puts(" ")
			puts(" There are #{tracks.length} tracks in " + albums[i-1].title + " album")
			for j in 1..(tracks.length)
				puts("  #{j}. " + tracks[j - 1].name)
			end
			puts(" ")
			count_1 = read_integer_in_range("  Enter your preferred track: ", 1, (tracks.length()))
			puts(" Playing the track of " + tracks[count_1 - 1].name.chomp + " from the album of " + albums[i-1].title)
			read_string(" Press ENTER to continue..\n")
		end
	end
end

def update_title(album)
	album.title = read_string("    Enter new title: ")
end

def update_genre(album)
	puts("    Choose the new genre: ")
	for i in 1..3
		puts("    #{i}. #{$genre_names[i]}")
	end
	album.genre = read_integer_in_range("    4. Rock ", 1, 4)
end

def update(albums)
	if (!albums)
		puts("You need to import albums first !!")
		puts(" ")
		return
	end
	puts(" ")
	count = read_integer_in_range(" Enter your album ID: ", 1, (albums.length()))
	puts(" ")
	puts("  What information do you want to update?")
	puts("  1. Update title")
	puts("  2. Update genre")
	count_1 = read_integer_in_range("  Enter your choice: ", 1, 2)
	puts(" ")
	if (count_1 == 1)
		update_title(albums[count - 1])
	else
		update_genre(albums[count - 1])
	end
	puts("  Information of album #{count} after updating:")
	puts("")
	display_album(albums[count - 1])
	puts("")
	read_string(" Press ENTER to continue..\n")
end

def main()
  	finished = false
  	begin
    	puts('Main Menu:')
	    puts('1. Read in Albums')
    	puts('2. Display Albums')
		puts('3. Play an Album')
    	puts('4. Update an Album')
		puts('5. Exit')
    	choice = read_integer_in_range("Please enter your choice:", 1, 5)
    	case choice
	    	when 1
      			albums = read_albums()
			when 2
	      		display(albums)
			when 3
				play(albums)
			when 4
				update(albums)
    	else
      		finished = true
    	end
  	end until finished
end

main
