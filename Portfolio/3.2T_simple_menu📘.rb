# By MOON

def read_string prompt
	puts prompt
	value = gets().chomp
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

def maintain_albums()
    f = false
    begin
        puts('Maintain Albums Menu:')
        puts('1 To Update Album Title')
        puts('2 To Update Album Genre')
        puts('3 To Enter Album')
        puts('4 Exit')
        c = read_integer_in_range("Please enter your choice:", 1, 4)
        case c
        when 1
            print('You selected Update Album Title. ')
            read_string("Press enter to continue")
        when 2
            print('You selected Update Album Genre. ')
            read_string("Press enter to continue")
        when 3
            print('You selected Enter Album. ')
            read_string("Press enter to continue")
        else 
            f = true
        end
    end until f
end

def play_existing_album()
    puts("You selected Play Existing Album. Press enter to continue")
    gets()
end
  
def main()
    finished = false
    begin
      puts('Main Menu:')
      puts('1 To Enter or Update Album')
      puts('2 To Play Existing Album')
      puts('3 Exit')
      choice = read_integer_in_range("Please enter your choice:", 1, 3)
      case choice
      when 1
        maintain_albums()
        when 2
        play_existing_album()
      else
        finished = true
      end
    end until finished
end

main
