#!/usr/bin/env ruby

# File I/O
# Reading a file and store is in variable "file"
# "file" will now be used for operation
File.open("ph_numbers_ruby.txt", "r") do |file|
=begin
    for line in file.readlines()
        puts line
    end
=end
    puts file
    puts file.readline()
    puts file.read().include? "808-234-5678"
    # puts file.read() # Print contents of file
    file.close()
end

# Appending to a file
File.open("ph_numbers_ruby.txt", "a") do |file|
    file.write("\n808-250-0149")
end

# Creating a new file
File.open("index.html" ,"w") do |file|
    file.write("<h1>Hello</h1>")
end

# Writting to a file to a specific line
File.open("ph_numbers_ruby.txt" ,"r+") do |file|
    file.readline()
    file.write("Testing r+ mode")
end