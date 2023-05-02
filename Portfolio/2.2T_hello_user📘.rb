# By MOON

require 'date'

def read_string prompt
	puts prompt
	value = gets.chomp
end

def read_float(prompt)
	value = read_string(prompt)
	value.to_f
end

def read_integer(prompt)
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

INCHES = 39.3701

def main()
  s = read_string('What is your name?')
  puts("Your name is " + s + "!")
  s = read_string('What is your family name?')
  puts("Your family name is: " + s + "!")
  i = read_integer('What year were you born?')
  y = Date.today.year - i
  puts("So you are " + y.to_s + " years old")
  f = read_float('Enter your height in metres (i.e as a float): ')
  f = f * INCHES
  puts("Your height in inches is: ")
  puts(f.to_s)
  puts("Finished")
  continue = read_boolean('Do you want to continue?')
  if (continue)
	  puts("Ok, lets continue")
  else
    puts("ok, goodbye")
  end
end

main()
