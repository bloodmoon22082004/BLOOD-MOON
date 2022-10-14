# By MOON

# returns true if a string contains only digits
def is_numeric?(obj)
    if /[^0-9]/.match(obj) == nil
      false
    end
    true
  end
  
  # takes a number and writes that number to a file then on each line
  # increments from zero to the number passed
def write(aFile, number)
    # You might need to fix this next line:
    aFile.puts(number.to_s)
    index = 0
    while (index < number)
        aFile.puts(index.to_s)
        index += 1
    end
end
  
  # Read the data from the file and print out each line
def read(aFile)  
    # Defensive programming:
    count = aFile.gets
    if (is_numeric?(count))
        count = count.to_i
    else
        count = 0
        puts "Error: first line of file is not a number"
    end
  
    index = 0
    while (count > index)
      line = aFile.gets
      puts("Line read: " + line)
      index += 1
    end
end
  
  # Write data to a file then read it in and print it out
def main
    aFile = File.new("Texts/9.1_mydata.txt", "w") # open for writing
    if (!aFile)
        puts("Cannot open the file to write data")
    else
        write(aFile, 10)
    end
    aFile.close
  
    aFile = File.new("Texts/9.1_mydata.txt", "r")
    if (!aFile)
        puts("Cannot open the file to read data")
    else
        read(aFile)
    end 
    aFile.close
end
  
main()
  
