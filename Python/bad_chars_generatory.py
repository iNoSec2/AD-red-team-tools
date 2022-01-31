#!/usr/bin/env python3
from __future__ import print_function

# Empty at first use "".split("\\x")
# After finding bad chars "\\x00\\x11\\x40\\x5f\\xb8\\xee".split("\\x")

listRem = "\\x00\\x0a".split("\\x")
for x in range(1, 256):
    if "{:02x}".format(x) not in listRem:
        print("\\x" + "{:02x}".format(x), end='')
print()