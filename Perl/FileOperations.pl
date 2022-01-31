#!/usr/bin/perl
use strict;
use warnings;

# A perl script that takes a file as an argument and read its contents
# to identify possible phone numbers based on the given criteria using regex.
#
# Author: Lyle Astillo

# Ends script if user entered none or more than 1 arguments.
# Also tells user how to use the script
my $dieMessage = "Error: Expecting 1 argument, found " . @ARGV . " instead.";
$dieMessage .= "\nUsage: perl FileOperations.pl filename\n";
die "$dieMessage" if (@ARGV != 1);

# Assigning file argument to a variable and creating a file handle for that varaible.
# If script cant open file, tell user that the text file they entered was invalid then end the script.
# If file is valid, use inputLine to store its contents line by line.
my $inputFile = $ARGV[0];
my $die_FH_Message = "Unable to open file: $inputFile\n";
open inFH, "<", $inputFile or die $die_FH_Message;
my $inputLine = "";

# Creating a file handle for outout file.
open outFH, ">", "valid_ph_numbers.txt";

# Store contents of file argument to inputLine and read each line of its contents.
while ($inputLine = <inFH>) {
    # Valid phone number formats XXX-XXX-XXXX OR (XXX)XXX-XXXX
    # Write contents that meets the phone number criteria to valid_ph_numbers.txt.
    if ($inputLine =~ m/(^(\(\d{3}\)|\d{3}-)\d{3}-\d{4}$)/) {
        print outFH "$inputLine";
    # Display contents that does not meet the criteria.
    } else {
        print "Invalid: $inputLine";
    }
}

# Closing both input and output files.
close inFH;
close outFH;

# Tells user that process is done.
print "\nDone! Valid numbers are written to valid_ph_numbers.txt"