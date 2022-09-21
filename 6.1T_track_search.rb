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
		puts "Please enter a value between " + min.to_s + min.to_s + ": "
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

class Track
	attr_accessor :name, :location
end

def read_track(music_file)
	track = music_file.gets.chomp()
	return track
end

def read_tracks(music_file)
	
	count = music_file.gets().to_i()
	track = []
	i = 0
	while (i<(count*2)) do
		i += 1
  		track[i] = read_track(music_file)
	end
	return track
end

def print_tracks(track)
	i = 0
	while (i < track.length) do
		i += 1
		if (i < track.length)
			puts(track[i])
		else
			print(track[i])
		end
	end
end

def search_for_track_name(tracks, search_string)
	i = 0
	while (i < (tracks.length / 2)) do
		i += 1
		if (search_string == tracks[2*i-1])
			if i == 1 
				found_index = 0
			elsif i == 2
				found_index = 1
			elsif i == 3
				found_index = 2
			else
				found_index = -1
			end
		end
	end
  	return found_index
end

def main()
  	music_file = File.new("Texts/6.1_album.txt", "r")
	tracks = read_tracks(music_file)
  	music_file.close()
	print_tracks(tracks)
  	search_string = read_string("Enter the track name you wish to find: ")
  	index = search_for_track_name(tracks, search_string)
  	if index > -1
   		puts "Found " + tracks[index*2+1] 
		puts " at " + index.to_s()
  	else
    	puts "Entry not Found"
  	end
end

main()
