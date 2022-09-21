class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

def read_tracks(music_file)
  count = music_file.gets().to_i()
  tracks = Array.new()
  i = 0
  while (i<count*2) do
    i += 1
    tracks[i] = music_file.gets.chomp
  end
  return tracks
end

def print_tracks(tracks)
  i = 0
  while (i< tracks.length) do
    i+=1
    if (i<tracks.length)
      puts(tracks[i])
    else
      print(tracks[i])
    end
  end
end

def print_track(track)
  puts(track.name)
	puts(track.location)
end

def main()
  a_file = File.new("Texts/5.1_input.txt", "r")
  tracks = read_tracks(a_file)
  print_tracks(tracks)
end

main()
