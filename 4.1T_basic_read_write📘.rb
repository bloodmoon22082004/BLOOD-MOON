# By BLOODMOON

def write_data_to_file(a_file)   
  a_file = File.new("Texts/4.1_mydata.txt", "w")   
    a_file.puts('5')   
    a_file.puts('Fred')   
    a_file.puts('Sam')   
    a_file.puts('Jill')   
    a_file.puts('Jenny')   
    a_file.puts('Zorro')   
  a_file.close()
end

def read_data_from_file(a_file)
  a_file = File.new("Texts/4.1_mydata.txt", "r")
    count = a_file.gets.to_i()    
    i = 0  
    while (i < count) do 
      puts a_file.gets()   
      i+=1  
    end  
  a_file.close()
end

def main   
  write_data_to_file("Texts/4.1_mydata.txt")      
  read_data_from_file("Texts/4.1_mydata.txt")  
end

main
