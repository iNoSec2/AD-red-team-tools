#!/usr/bin/env ruby

# Error Handling
test_array = [1, 2, 3, 4]
begin
    test_array["69"]
    div_error = 10 / 0
rescue ZeroDivisionError => e
    puts e
rescue TypeError => e
    puts e
end
