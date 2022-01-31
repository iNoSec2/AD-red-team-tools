# Creating a module which is a ruby script with methods
# This will be imported to ruby_script_course5_1.rb
module ModuleName
    def sayHi(name)
        puts "Hello #{name}"
    end

    def sayBye(name)
        puts "Bye #{name}"
    end
end