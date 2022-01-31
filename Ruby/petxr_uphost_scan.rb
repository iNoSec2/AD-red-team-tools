#!/usr/bin/ruby

#The following script requires 'uphosts' and 'pextr' files.

# open3 is required 
require 'open3'

# commands used by the script
Ping_command = "nmap -PE -sn -n "
Extract_ip_command = "uphosts -oN "	
UDP_command = "nmap -sU -n "
TCP_C_command = "nmap -sT -n "
TCP_SYN_command = "nmap -sS -n "
Extract_port_command = "pextr %s %s -oN"  
TARGET = ARGV[0]


# main execution:
# - performs an ICMP echo request (ping sweept) against the target network and then prints alive hosts
# - prints the menu and wait for a choice
# - according to the selected option it executes a port scan (UDP,TCP Connection, TCP SYN)
# - finally it prints to stdout the open and filtered ports 
def main
  puts "Target: " + TARGET
	up_hosts = get_up_hosts(TARGET)
	case print_menu()
		when 1 then scan(up_hosts,UDP_command) 
		when 2 then scan(up_hosts,TCP_C_command)
		when 3 then scan(up_hosts,TCP_SYN_command)
		when 99 then return
	end
	exit
end


# main menu logic code
def print_menu()
st = <<END

Menu:
1) UDP scan
2) TCP Full Connection scan
3) TCP SYN scan
99) Quit

END
	puts st
	print "Select: "
	return $stdin.gets.to_i
end




# ICMP echo (ping sweep) logic code
def  get_up_hosts(target)
	puts "Ping sweep..."
	out = `#{Ping_command+target}`
	sin,sout = Open3.popen3(Extract_ip_command)
	sin.puts(out)
	sin.close
	puts "\nALIVE HOSTS"
	up_hosts = []
	sout.each_with_index {|ip,i| up_hosts.push ip; puts i.to_s+") "+ip}
	return up_hosts
end


# port scan logic code
def scan(up_hosts,command)
	print "Target host (0-"+(up_hosts.length-1).to_s+"): "
	i = $stdin.gets.to_i
	puts "Nmap scanning..."
	out = `#{command+up_hosts[i]}`
	puts "\nHost: " + up_hosts[i]

	sin,sout = Open3.popen3(Extract_port_command % [up_hosts[i].chop,"-open"])
	sin.puts(out)
	sin.close
	print "Open: "
	sout.each { |port| print port.chop+" "}

	sin,sout = Open3.popen3(Extract_port_command % [up_hosts[i].chop,"-filtered"])
	sin.puts(out)
	sin.close
	print "\nFiltered: "
	sout.each { |port| print port.chop+" "}

end

# exit logic
def exit
	print "\n\nExit [y/n]: "
	c = nil
	loop do 
		c = $stdin.gets.chop
		break if (c=="y" || c=="n")
	end
	puts
	main if c == "n"
	return if c=="y"	
end

# the script execution starts here
begin
	main
rescue Exception => ex
	puts ex
end