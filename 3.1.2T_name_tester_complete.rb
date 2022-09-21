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
def print_silly_name(name)
	puts(name + " is a")
	i = 0
	while i < 60 do
  		print("silly ")
  		i += 1
	end
	puts("name!")
end

def main
  name = read_string("What is your name?")
  if name == "Trung" or name == "Mathew"
    puts(name + " is an awesome name!")
  else
    print_silly_name(name)
  end
end

main
