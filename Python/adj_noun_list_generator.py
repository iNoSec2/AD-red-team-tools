#!/usr/bin/env python3
from itertools import product

nouns = open('noun.txt', 'r')
nouns_reader = nouns.readlines()
nouns_list = []

adjectives = open('adjectives.txt', 'r')
adjectives_reader = adjectives.readlines()
adjectives_list = []

output = open('combined.txt', 'w')

for lines in nouns_reader:
    nouns_list.append(lines.lower().rstrip('\n'))
for lines in adjectives_reader:
    adjectives_list.append(lines.lower().rstrip('\n'))

combos = list(product(adjectives_list, nouns_list))

for content in combos:
    passwords = ''.join(content)
    output.write(passwords + '\n')
    
nouns.close()
adjectives.close()
output.close()