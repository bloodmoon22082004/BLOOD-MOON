# By MOON

require 'date'

def get_age()
  puts("Enter your age in years: ")
  age = gets().to_i()
  return age
end

def get_string(prompt)
  puts(prompt)
  s = gets().chomp()
  return s
end

def print_year_born(name,age)
  year_born = Date.today.year -  age
  puts(name + " you were born in: " + year_born.to_s)
end

def main()
  age = get_age().to_i
  name = get_string("Enter your name")
  print_year_born(name,age)
end

main()
