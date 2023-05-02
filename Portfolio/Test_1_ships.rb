# By MOON

# Use the scaffold code provided for this task. Complete the following code requirements in the Ruby language for the file ship.rb. Your final code must be structured and run. 
# Requirements:
#   1. You must create a record for a ship. A ship has the following attributes: a name (string), an id (integer), a destination port and an origin port (strings). In your code create a Ruby class that can be used to create records for the ship using the field names for each attribute. 
#   2. Write a function called read_a_ship() that reads from the terminal values for each of the fields in a Ship record and returns the completed record.
#   3. Write a procedure called print_a_ship(ship) that takes a ship record and writes each of the fields to the terminal with a description for the field as well as the field value.
#   4. Write a function called read_ships() that calls your read_a_ship() and returns an array of ships.
#   5. Write a procedure called print_ships(ships); that calls your print_a_ship(ship) procedure for each ship in the array.
#   6. Use the following code in your main() to test your program

require './input_functions'

class Ship
	attr_accessor :name, :id, :origin, :destination

	def initialize(name, id, origin, destination)
		@name = name
		@id = id
		@origin = origin
		@destination = destination
	end

end

# Complete the code below
# Use input_functions to read the data from the user

def read_a_ship()
	name = read_string("Enter ship name:")
	id = read_string("Enter ship id:")
	origin = read_string("Enter port of origin:")
	destination = read_string("Enter destination port:")
	ship = Ship.new(name, id, origin, destination)
	return ship
end

def read_ships()
	count = read_integer("How many ships are you entering:")
	ships = Array.new()
	while (count > 0)
		ship = read_a_ship()
		ships << ship
		count -= 1
	end
	return ships
end

def print_a_ship(ship)
	puts("Ship name: " + ship.name.chomp)
	puts("Ship id: " + ship.id.chomp)
	puts("Port of origin: " + ship.origin.chomp)
	puts("Destination port: " + ship.destination.chomp)
end

def print_ships(ships)
	index = 0
	while (index < ships.length)
		print_a_ship(ships[index])
		index += 1
	end
end

def main()
	ships = read_ships()
	print_ships(ships)
end

main()
