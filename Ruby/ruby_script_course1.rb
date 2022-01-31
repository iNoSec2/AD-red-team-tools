#!/usr/bin/env ruby

# Ways to output text
puts "Hello World"
print "Hello World"

# Drawing a triangle.
puts ""
puts "   /\\"
puts "  /  \\"
puts " /    \\"
puts "/______\\"
puts ""

# Put stiring inside ("") when concatinating with vairables.
var1 = "test variable 1"
var2 = "test variable 2"

puts ("Variables and concatination: " + var1 + var2 + "\n")

# Data types
intgr = 1
flt = 1.23
bln = true
no_val = nil

# String methods.
test_str = " Test string "
puts test_str.upcase()
puts test_str.strip()
puts test_str.length()
puts test_str.include? "Test" # Should return true becasue Test exists
puts test_str[1,4].upcase() 
puts test_str.index('T') # Returns location of T in Test string

# Number methods
test_num1 = 1
test_num2 = 1.23
puts test_num1 + test_num2
puts test_num2**3
puts 10 % 3 # Modulo and should output 1
puts ("String with numbers: " + test_num1.to_s) # Concatinates strings with numbers
puts test_num2.ceil()
puts Math.log(test_num2)


# Getting user input
puts "Enter your name: "
name = gets.chomp()
puts ("Hello " + name + ", Q_Q")

# Creating a Mad Libs game
puts "Enter a color: "
color = gets.chomp()

puts "Enter a plural noun: "
noun = gets.chomp()

puts "Enter a celebrity: "
celebrity = gets.chomp()

puts ("Roses are " + color)
puts (noun + " are blue ")
puts ("I love " + celebrity)

# Arrays
friends = Array["test1", "test2", "test3"]
puts friends
puts friends[1]
puts friends[0, 2]
puts friends[2] = "test4"
puts friends.length()
puts friends.include? "test2"
puts friends.sort()

empty_arr = Array.new
puts empty_arr

# Hashes a.k.a Dictionaries in Python
states = {
    "Key" => "Value",
    "Hawaii" => "HI",
    "New York" => "NY",
    "California" => "CA",
    1 => 2
}
puts states
puts states["Key"]
puts states["Hawaii"]
puts states[1]

# Methods
def sayHello(name, type, age=25)
    puts ("Hello " + name + " you are " + age.to_s + " and a " + type)
end

def cube(num)
    return num * num * num
end

sayHello("Lyle", "beast")
puts cube(2)

# If Statements
# and, or are used as conditional operators
# ==, > <, >=,<=
test_var1 = true
test_var2 = false

if test_var1 and test_var2
    puts "should not print"
elsif test_var1 and !test_var2
    puts "This should be printed"
else
    puts "should not print"
end

def max(num1, num2, num3)
    if num1 >= num2 and num1 >= num3
        return num1
    elsif num2 >= num1 and num2 >= num3
        return num2
    else
        return num3
    end
end

puts ("The biggest number is: " + max(1, 2, 3).to_s)

# Four function Calculator using user input nand if-else statement
puts "Enter fist number: "
num1 = gets.chomp().to_f
puts "Enter operator: "
operator = gets.chomp()
puts "Enter second number: "
num2 = gets.chomp().to_f

if operator == "+"
    puts (num1 + num2)
elsif operator == "-"
    puts (num1 - num2)
elsif operator == "*"
    puts (num1 * num2)
elsif operator == "/"
    puts (num1 / num2)
else
    puts "Invalid operator"
end

# Case statements
def get_day_name(day)
    day_name = ""
    case day
    when "mon"
        day_name = "Monday"
    when "tue"
        day_name = "Tuesday"
    when "wed"
        day_name = "Wednesday"
    when "thurs"
        day_name = "Thursday"
    when "fri"
        day_name = "Friday"
    when "sat"
        day_name = "Saturday"
    when "sun"
        day_name = "Sunday"
    else
        day_name = "Invalid day"
    end
    return day_name
end
puts get_day_name("mOn")

# While loop
index = 1
while index <= 3
    puts index
    index += 1
end

# Guessing game using while loop and if statement
secret_word = "test"
guess = ""
guess_counter = 0
guess_limit = 3
lost = false

while guess != secret_word and !lost
    if guess_counter < guess_limit
        puts "Enter the magic word"
        guess = gets.chomp()
        guess_counter += 1
    else
        lost = true
    end
end
if lost
    puts "Out of guesses, You lost!"
else
    puts "You guessed the magic word"
end

# For loop
amigos = ["test1", "test2", "test3"]
for element in amigos
    puts element
end

# Loop through amigos array
amigos.each do |friend|
    puts friend
end

# Print range of numbers 1-5
for num in 1..5
    puts num
end

# Print range of numbers 1-5
5.times do |num|
    puts num
end


# Method that performs exponential operation on positive numbers
def exponential(base_num, pow_num)
    result = 1
    pow_num.times do
        result = result * base_num
    end
    return result
end
puts exponential(5,2) # 5 ^ 2 = 25