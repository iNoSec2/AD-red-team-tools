#!/usr/bin/ruby

# prints how to use the script; it is
# called when wrong arguments are provided
def usage
st = <<END
pextr eLearnSecurity \u00A9 2014
It extracts (open|filtered|closed) ports
of a specified ip address from nmap results.
Usage: pextr ip [Port State] [File Type] file|stream

PORT STATE
 -open      opened ports (default)
 -filtered  filtered ports
 -closed    closed ports
	
FILE TYPE
 -oX when file is an xml nmap output
 -oN when file is a normal nmap output
 -oG when file is a grepable nmap output
	
 [File Type] is not required when file has 
 .nmap | .xml | .gnmap extension

EXAMPLES
 pextr 10.50.97.5 nmap.xml
 pextr 10.50.97.5 -filtered -oX nmap.xmlout
 pextr 10.50.97.5 -closed file.nmap
 nmap -sS -n 192.168.1.15 | pextr 192.168.1.15 -oN

END
	puts st
end

# return nil if ip is not a really ip
def match_ip(ip)
	ip =~ /(\d{1,3}\.){3}\d{1,3}/
end

# detect if status is provided as argument
# if not -> "open" is default
def match_state(state)
	case state
		when "-open" then "open"
		when "-closed" then "closed"
		when "-filtered" then "filtered"
		else ["open",true]
	end
end

# detect what is the file type (normal, grepable, xml)
# according to the command arguments
def match_file(type,name)
	extensions = [".nmap",".xml",".gnmap"]
	types = ["-oN","-oX","-oG"]
	case 
		when type == nil then usage
		when (types.include? type) then [type,name]
		when (extensions.include? File.extname type) then [types[extensions.index (File.extname type)],type]
		else raise Exception.new("Supported extensions: "+ extensions.join(" | ")) 	
	end
end

# we have already extracted all the parameters
# main calls the correct logic method for the file type
def main(f_type,file,status,ip)
	case f_type
		when "-oN" then normal(file,status,ip)
		when "-oG" then grepable(file,status,ip)
		when "-oX" then xml(file,status,ip)
	end
end


# extraction by a normal nmap file or stream
def normal(file,state,ip)
	ip_pattern = /^Nmap scan report for #{ip}$/
	up_host_pattern = /^Host is up (?:.)*\n/
	port_pattern = /^(?:(\d+)\/\w+\s+#{state}\s+.+\n)/
	
	# if a file is provided we use it
	# else stdin is used
	if file then stream = File.new(file)
	else stream = $stdin end
	
	stream.each do |line|     	    # for each line of the stream
		line.match(ip_pattern) do   	# if the ip is found
										# and the ip host is up, we have to 
										#extract each (open|closed|filtered) port
			stream.readline.match up_host_pattern do
				stream.readline 		      # reads line of type: "Not shown: * closed ports"
				stream.readline 	      	  # reads line of type: "PORT STATE SERVICE"
				stream.each do |line| 		  # from here, each line stores the port 					
					line =~ port_pattern      # line -> matches the port sub-pattern 
					puts $1 if $1			      #  -> print to stdout the port
					break if line == "\n"		# no more ports -> exit from block						
				end
			end
		end
	end

end

# extraction by a grepable nmap file or stream
def grepable(file,state,ip)

	# if a file is provided we use it
	# else stdin is used
	if file then stream = File.new(file)
	else stream = $stdin end
	
	up_host = /^Host:\s#{ip}\s\(\)\s+Status: Up/
	port_pattern = /(?:\s(\d+)\/#{state}\/[^\/]+\/\/[^\/]+\/\/\/)/

	# for each line of the stream
	stream.each do |line|
		# if the wanted ip is found
		line.match(up_host) do 
			# read the next line and extract each port with scan method
			stream.readline.scan(port_pattern) {|port| puts port}
		end
	end

end

# extraction by an xml nmap file or stream
def xml(file,state,ip)
	require "rexml/document"

	# if a file is provided we use it
	# else stdin is used
	if file then stream = File.new(file)
	else stream = $stdin end
	
	# parse the xml file to create a tree
	doc = REXML::Document.new stream
	
	# XPath syntax to extract only the desired ports
	pattern = "//host[address/@addr='#{ip}']//port[state/@state='#{state}']"

	# for each address node child of host node
	# puts to stdout the addr attribute
	doc.elements.each(pattern) do |port|
	 puts port.attributes["portid"]
	end

end


# THE SCRIPT STARTS HERE
begin

	(usage;exit) if !match_ip(ARGV[0])
	ip = ARGV[0]

	state,default = match_state(ARGV[1])
	type = default ? ARGV[1] : ARGV[2]
	file = default ? ARGV[2] : ARGV[3]
	f_type,file = match_file(type,file)
	
	main(f_type,file,state,ip)

rescue SystemExit
rescue Exception => e
	puts e

end