# By MOON

def read_string prompt
	puts prompt
	value = gets.chomp
end

def read_float prompt
	value = read_string(prompt)
	value.to_f
end

def read_integer prompt
	value = read_string(prompt)
	value.to_i
end


def read_integer_in_range(prompt, min, max)
	value = read_integer(prompt)
	while (value < min or value > max)
		puts "Please enter a value between " + min.to_s + " and " + max.to_s + ": "
		value = read_integer(prompt);
	end
	value
end

def read_boolean prompt
	value = read_string(prompt)
	case value
	when 'y', 'yes', 'Yes', 'YES'
		true
	else
		false
	end
end

module Genre
    POP, CLASSIC, JAZZ, ROCK = *1..4
  end
  
  $genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']
  
  class Album
    attr_accessor :title, :artist, :genre
    
  end
  
  def read_album(pattern)
    puts(pattern)
    album_title = read_string("Enter album name:")
    album_artist = read_string("Enter artist name:")
    i = read_integer_in_range("Enter Genre between 1 - 4: ",1,4)
    album = Album.new()
    album.title = album_title
    album.artist = album_artist
    album.genre = i
    return album
  end
  
  def print_album(album)
    puts('Album information is: ')
    puts(album.title)
    puts(album.artist)
      puts('Genre is ' + album.genre.to_s)
      puts($genre_names[album.genre])
  end
  
  def main()
      album = read_album("Enter Album")
      print_album(album)
  end
  
  main()
