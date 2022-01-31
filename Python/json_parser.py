#!/usr/bin/env python3
import json

with open("eve_alert.json", "r") as jf:
    data = jf.read()
contents = json.loads(data)

for d in contents:
    #print(d["proto"])
    if d["proto"] == "UDP":
        print(d["alert"]["category"])

jf.close()