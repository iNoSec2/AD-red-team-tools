#!/usr/bin/ruby

# this method contains the main script logic
def main(opt,file)
	case opt
		when nil then usage
		when "-oN" then normal file
		when "-oG" then grepable file
		when "-oX" then xml file
		else detect opt
	end
end 

# prints how to use the script; it is
# called when no arguments are provided
def usage
st = <<END
uphosts eLearnSecurity \u00A9 2014
It extracts ip addresses from nmap results.
Usage: uphosts [File Type] file|stream

FILE TYPE
 -oX when file is an xml nmap output
 -oN when file is a normal nmap output
 -oG when file is a grepable nmap output
	
 [File Type] is not required when file has 
 .nmap | .xml | .gnmap extension

EXAMPLES
 uphosts scan.nmap
 uphosts -oX xml_file
 uphosts -oN nmap_scan.normal
 nmap -PE -sn -n 10.0.2.0/24 -oX - | uphosts -oX
 nmap [options] targets [type] | uphost [FileType]

END
	puts st
end


# normal nmap output
def normal(file)
	pattern =  /^(?:Nmap scan report for )((?:\d{1,3}\.){3}\d{1,3})/
	regexp(file,pattern)
end

# grepable nmap output
def grepable(file)
	pattern =   /^(?:Host:)\s((?:\d{1,3}\.){3}\d{1,3})/
	regexp(file,pattern)
end

# xml nmap output
def xml(file)
	require "rexml/document"

	# if a file is provided we use it
	# else stdin is used
	if file then stream = File.new(file)
	else stream = $stdin end
	
	# parses input stream
	doc = REXML::Document.new stream

	# extracts ip addresses from node
	doc.elements.each("//host/address[@addrtype='ipv4']") do |addr|
	 puts addr.attributes["addr"]
	end
end

# extracts pattern from file lines
def regexp(file,pattern)
	
	# if a file is provided we use it
	# else stdin is used
	if file then stream = File.new(file)
	else stream = $stdin end


	# extracts ip addresses from each line
	stream.each do |line|
		pattern =~ line
		puts $1 if $1
	end

end

# if no option is provided the script detects if a standard
# nmap output file is provided (.nmap | .xml | .gnmap)
def detect(file)
	extensions = [".nmap",".xml",".gnmap"]
	opt = ["-oN","-oX","-oG"]
	i = extensions.index(File.extname file)
	# if the file has a valid standard extension we retry
	# the main method with correct option
	(main(opt[i],file);return) if i
	# otherwise an exception occurs
	raise Exception.new("Supported extensions: "+ extensions.join(" | "))
end


# THE SCRIPT START HERE
begin
	main(ARGV[0],ARGV[1])
rescue Exception => e
	puts e
end