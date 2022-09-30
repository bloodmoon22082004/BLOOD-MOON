# By BLOODMOON

def factorial(n)
    ref = 1
    for i in 1..n
        ref *= i
    end
    return ref
end

def main
  ARGV[0] = gets.to_i
  if (ARGV[0] < 1) || (ARGV.length < 1)
    puts("Incorrect argument - need a single argument with a value of 0 or more.\n")
  else
    puts factorial(ARGV[0])
  end
end

main
