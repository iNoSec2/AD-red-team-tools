import socket
import sys

IP = ''
PORT = 1234

# Use /usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l
buffer = ""

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((IP, PORT))
    print("Sending buffer")
    s.send(buffer.encode())
    print("Done")

except:
    print("Fuzzer failed, check IP and PORT")
    sys.exit()