from AstilloLyle02 import *; # Change LastnameFirstname02 to your own LastnameFirstname02

"""
  game.py will test the functions addInventory and attack defined in a separate file.
  The game will deal with a playable character that can attack enemies and collect items in an inventory.
  This file and LastnameFirstname02.py must be in the same folder.
  Author: Ed Meyer
"""
# ~~~ Do not modify code beyond this point ~~~ #

# The players current inventory.
inventory = {
  'rope': 1,
  'torch': 6,
  'gold coin': 42,
  'dagger': 1
};

# Items collected from defeating a monster.
loot = ['gold coin', 'dagger', 'gold coin', 'ruby'];

# Display the inventory before obtaining items.
print("Before loot:");
print(inventory);

# Add the items to the player's inventory.
addInventory(inventory, loot);

# Display the updated inventory.
print("\nAfter loot:");
print(inventory);
print();

# Simulate attacking 5 times with no attack modifier.
print("Attacking 5 times...");
for i in range(0, 5):
    print(attack());

# Simulate attacking 5 times with a 20% attack modifier.
print("Attacking 5 times with 1.2 modifier");
for i in range(0, 5):
    print(attack(1.2));

# The attack modifier is capped at 1.5, any number higher will not affect damage calculation.
print("Attacking 5 times with 100 modifier");
for i in range(0, 5):
    print(attack(100));
