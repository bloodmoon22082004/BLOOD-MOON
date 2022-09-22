# By BLOODMOON

def read_string(pattern):
    print(pattern)
    string = input()
    return string

def print_silly_name(name):
    # complete this
    print(name + " is a")
    index = 0
    while (index < 60):
        print("silly", end=" ")
        index += 1
    print("name!")

def main():
    name = read_string("What is your name?")
    if name == "Trung" or name == "Matthew":
        print(name + " is an awesome name!")
    else:
        print_silly_name(name)

main()
