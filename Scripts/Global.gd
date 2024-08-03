### Global.gd
extends Node

# Custom signals
signal inventory_updated

# Inventory items
var inventory := []
var scene_path: String = "res://Scenes/Inventory_Item.tscn"



# Array of spawnable items > avoid special "quest" items, use commons for drops


var consumable_items :=[
	{"type": "Consumable","name": "Peach","effect": "Health","texture": preload("res://assets/Icons/icon31.png")},
	{"type": "Gift","name": "Gemstone","effect": "","texture": preload("res://assets/Icons/icon21.png")},
]

var spawnable_items := [
	{"type": "Mineral","name": "Ruby","effect": "Red as blood","texture": preload("res://assets/Icons/icon26.png")},
	{"type": "Mineral","name": "Diamond","effect": "Sparks and flases","texture": preload("res://assets/Sprites/diamond.png")},
	{"type": "Mineral","name": "Emerald","effect": "Appreciated by villagers","texture": preload("res://assets/Icons/icon25.png")},
	{"type": "Mineral","name": "Amethyst","effect": "Smells like grapes","texture": preload("res://assets/Icons/icon3.png")},
	{"type": "Organic","name": "Rose","effect": "Comes with spines","texture": preload("res://assets/Icons/icon31.png")},
	{"type": "Organic","name": "Mushroom","effect": "Can f+ck some1up","texture": preload("res://assets/Icons/icon32.png")},
	{"type": "Organic","name": "Wild Grapes","effect": "Not that sweet","texture": preload("res://assets/Sprites/grapes.png")},
	{"type": "Organic","name": "Mint Leaf","effect": "Refreshing taste","texture": preload("res://assets/Sprites/mint.png")},
	{"type": "Memento","name": "Leather Boots","effect": "Smells really bad","texture": preload("res://assets/Sprites/boot.png")},
	{"type": "Memento","name": "Rusty Rod","effect": "Ancient lost tool","texture": preload("res://assets/Sprites/coal.png")},
	{"type": "Memento","name": "Rags Shirt","effect": "Regular peasants clothing","texture": preload("res://assets/Sprites/shirt.png")},
	{"type": "Memento","name": "Gold Crown","effect": "Can't be sold","texture": preload("res://assets/Sprites/crown.png")},
]

var craftable_items := [
	{"quantity": 1,"type": "Potion","name": "Mundane Crimson Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Crimson Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Crimson Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Crimson Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon15.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Crimson Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Crimson Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Crimson Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Crimson Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon15.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Crimson Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Crimson Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Crimson Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Crimson Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon15.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Crimson Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Crimson Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Crimson Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon15.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Crimson Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon15.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Sparkling Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Sparkling Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Sparkling Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Sparkling Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon12.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Sparkling Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Sparkling Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Sparkling Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Sparkling Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon12.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Sparkling Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Sparkling Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Sparkling Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Sparkling Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon12.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Sparkling Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Sparkling Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Sparkling Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon12.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Sparkling Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon12.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Verdant Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Verdant Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Verdant Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Verdant Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon10.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Verdant Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Verdant Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Verdant Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Verdant Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon10.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Verdant Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Verdant Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Verdant Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Verdant Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon10.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Verdant Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Verdant Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Verdant Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon10.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Verdant Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon10.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Violet Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Violet Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Violet Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Violet Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon6.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Violet Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Violet Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Violet Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Violet Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon6.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Violet Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Violet Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Violet Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Violet Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon6.png")},
	
	{"quantity": 1,"type": "Potion","name": "Mundane Violet Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Royal Violet Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Strong Violet Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon6.png")},
	{"quantity": 1,"type": "Potion","name": "Ancient Violet Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon6.png")}
]


var crafting_recipes := [
	# Crimson Joy Potion variations
	{"type": "Recipe","name": "Mundane Crimson Joy Potion","recipe": "Ruby,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Joy Potion","recipe": "Ruby,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Joy Potion","recipe": "Ruby,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Joy Potion","recipe": "Ruby,Rose,Rusty Rod"},

	# Crimson Calm Potion variations
	{"type": "Recipe","name": "Mundane Crimson Calm Potion","recipe": "Ruby,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Calm Potion","recipe": "Ruby,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Calm Potion","recipe": "Ruby,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Calm Potion","recipe": "Ruby,Mushroom,Rusty Rod"},

	# Crimson Warming Potion variations
	{"type": "Recipe","name": "Mundane Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Rusty Rod"},

	# Crimson Cooling Potion variations
	{"type": "Recipe","name": "Mundane Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Rusty Rod"},

	# Sparkling Joy Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Joy Potion","recipe": "Diamond,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Joy Potion","recipe": "Diamond,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Joy Potion","recipe": "Diamond,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Joy Potion","recipe": "Diamond,Rose,Rusty Rod"},

	# Sparkling Calm Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Calm Potion","recipe": "Diamond,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Calm Potion","recipe": "Diamond,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Calm Potion","recipe": "Diamond,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Calm Potion","recipe": "Diamond,Mushroom,Rusty Rod"},

	# Sparkling Warming Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Rusty Rod"},

	# Sparkling Cooling Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Rusty Rod"},

	# Verdant Joy Potion variations
	{"type": "Recipe","name": "Mundane Verdant Joy Potion","recipe": "Emerald,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Joy Potion","recipe": "Emerald,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Joy Potion","recipe": "Emerald,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Joy Potion","recipe": "Emerald,Rose,Rusty Rod"},

	# Verdant Calm Potion variations
	{"type": "Recipe","name": "Mundane Verdant Calm Potion","recipe": "Emerald,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Calm Potion","recipe": "Emerald,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Calm Potion","recipe": "Emerald,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Calm Potion","recipe": "Emerald,Mushroom,Rusty Rod"},

	# Verdant Warming Potion variations
	{"type": "Recipe","name": "Mundane Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Rusty Rod"},

	# Verdant Cooling Potion variations
	{"type": "Recipe","name": "Mundane Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Rusty Rod"},

	# Violet Joy Potion variations
	{"type": "Recipe","name": "Mundane Violet Joy Potion","recipe": "Amethyst,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Joy Potion","recipe": "Amethyst,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Joy Potion","recipe": "Amethyst,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Joy Potion","recipe": "Amethyst,Rose,Rusty Rod"},

	# Violet Calm Potion variations
	{"type": "Recipe","name": "Mundane Violet Calm Potion","recipe": "Amethyst,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Calm Potion","recipe": "Amethyst,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Calm Potion","recipe": "Amethyst,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Calm Potion","recipe": "Amethyst,Mushroom,Rusty Rod"},

	# Violet Warming Potion variations
	{"type": "Recipe","name": "Mundane Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Rusty Rod"},

	# Violet Cooling Potion variations
	{"type": "Recipe","name": "Mundane Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Rusty Rod"}
]




# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene := preload("res://Scenes/Inventory_Slot.tscn")

# Variables to hold the hotbar settings
var hotbar_size := 5
var hotbar_inventory := []
var hotbar_used := 0


var craftbar_size := 3
var craftbar_inventory := []
var craftbar_used := 0

var outbar_size := 1
var outbar_inventory := []
var outbar_used := 0

func _ready(): 
	# Initializes the inventory with 30 slots (spread over 9 blocks per row)
	inventory.resize(27)
	hotbar_inventory.resize(hotbar_size)
	craftbar_inventory.resize(craftbar_size)
	outbar_inventory.resize(outbar_size)
	
# Sets the player reference for inventory interactions
func set_player_reference(player):
	player_node = player
	
# Adds an item to the inventory, returns true if successful
func add_item(item, to_hotbar := false, to_craft := false):
	
	var added_to_hotbar := false
	var added_to_craftbar := false
	if to_hotbar and hotbar_used < hotbar_size:
		added_to_hotbar = add_hotbar_item(item)
		inventory_updated.emit()
		hotbar_used += 1
		print("added to hot!")
		print("filled 1 slot on hotbar ", hotbar_used)

	if to_craft:
		added_to_craftbar = add_craftbar_item(item)
		inventory_updated.emit()
		print("added to craft!")

	if not added_to_hotbar and not added_to_craftbar:
		print("we gonna add to inventory!")
		for i in range(inventory.size()):
			# Check if the item exists in the inventory and matches both type and effect
			if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
				inventory[i]["quantity"] += item["quantity"]
				inventory_updated.emit()
				print("Item added", item)
				return true
			elif inventory[i] == null:
				inventory[i] = item
				inventory_updated.emit()
				print("Item added", item)
				return true
		return false

# Removes an item from the inventory based on type and effect
func remove_item(item_type, item_effect):
	for i in range(inventory.size()):
		# Check if the item exists in the inventory and matches both type and effect
		if inventory[i] != null and inventory[i]["type"] == item_type and inventory[i]["effect"] == item_effect:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false

# Increase inventory size dynamically
func increase_inventory_size(extra_slots):
	inventory.resize(inventory.size() + extra_slots)
	inventory_updated.emit()
	
# Function to determine a valid drop position so we can drop items on the map
func adjust_drop_position(position):
	var radius := 60
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_position.distance_to(position) < radius:
			var random_offset := Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position
	
# Function to drop the items after calculating a valid drop position

func drop_item(item_data, drop_position):
	var item_scene := load(item_data["scene_path"])
	var item_instance : Node2D = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position = adjust_drop_position(drop_position)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)


#add an item to the hotbar when assigned?
func add_hotbar_item(item):
	for i in range(hotbar_size):
		if hotbar_inventory[i] == null:
			hotbar_inventory[i] = item
			return true
	return false

func add_craftbar_item(item):
	for i in range(craftbar_size):
		if craftbar_inventory[i] == null:
			craftbar_inventory[i] = item
			return true
	return false

#remove an item from the hotbar when its used or consumed to 0 so UPDATE not DELETE
func remove_hotbar_item(item_type, item_effect):
	for i in range(hotbar_inventory.size()):
		if hotbar_inventory[i] != null and hotbar_inventory[i]["type"] == item_type and hotbar_inventory[i]["effect"] == item_effect:
			if hotbar_inventory[i]["quantity"] <= 0:
				hotbar_inventory[i] = null
			inventory_updated.emit()
			return true
	return false

func remove_outbar_item(item_type, item_effect):
	outbar_inventory[0] = null

#unassign item from the hotbar without deleting it
func unassign_hotbar_item(item_type, item_effect):
	for i in range(hotbar_inventory.size()):
		if hotbar_inventory[i] != null and hotbar_inventory[i]["type"] == item_type and hotbar_inventory[i]["effect"] == item_effect:
			hotbar_inventory[i] = null
			inventory_updated.emit()
			return true
	return false

#unassign item from the hotbar without deleting it
func unassign_craftbar_item(item_type, item_effect):
	for i in range(craftbar_inventory.size()):
		if craftbar_inventory[i] != null and craftbar_inventory[i]["type"] == item_type and craftbar_inventory[i]["effect"] == item_effect:
			craftbar_inventory[i] = null
			inventory_updated.emit()
			return true
	return false

#Prevents duplicate item assigment
func is_item_assigned_to_hotbar(item_to_check):
	return item_to_check in hotbar_inventory
	
func is_item_assigned_to_craftbar(item_to_check):
	return item_to_check in craftbar_inventory

#Swaps inventory items based on their indices
func swap_inventory_items(index1, index2):
	if index1 < 0 or index1 > inventory.size() or index2 < 0 or index2 > inventory.size():
		return false
	#var temp : Dictionary = inventory[index1]
	var temp = inventory[index1]
	inventory[index1] = inventory[index2]
	inventory[index2] = temp
	inventory_updated.emit()
	return true


#Swaps hotbar items based on their indices
func swap_hotbar_items(index1, index2):
	if index1 < 0 or index1 > hotbar_inventory.size() or index2 < 0 or index2 > hotbar_inventory.size():
		return false
	var temp = hotbar_inventory[index1]
	hotbar_inventory[index1] = hotbar_inventory[index2]
	hotbar_inventory[index2] = temp
	inventory_updated.emit()
	return true

func swap_craftbar_items(index1, index2):
	if index1 < 0 or index1 > craftbar_inventory.size() or index2 < 0 or index2 > craftbar_inventory.size():
		return false
	var temp = craftbar_inventory[index1]
	craftbar_inventory[index1] = craftbar_inventory[index2]
	craftbar_inventory[index2] = temp
	inventory_updated.emit()
	return true

func is_hotbar_full():
	for i in range(hotbar_inventory.size()):
		if hotbar_inventory[i] == null:
			return false
	return true

func is_craftbar_full():
	for i in range(craftbar_inventory.size()):
		if craftbar_inventory[i] == null:
			return false
	return true

# Función para obtener la clave de la receta (ordenada)
func get_recipe_key(ingredients):
	var sorted_ingredients = ingredients.duplicate()

	print("sorted ingredientes",sorted_ingredients)
	return String(",".join(sorted_ingredients))

# Función para encontrar una receta válida y craftear la poción
func craft_potion(craftbar):
	# Extraer nombres de los ingredientes de entrada
	var ingredient_names = []
	for item in craftbar:
		if item != null:
			ingredient_names.append(item["name"])
			print(ingredient_names)
	
	# Asegurarse de que se tengan tres ingredientes
	if ingredient_names.size() != 3:
		print("Debe tener exactamente tres ingredientes en los espacios de entrada.")
		return
	
	# Crear la clave de la receta
	var recipe_key = get_recipe_key(ingredient_names)
	
	# Buscar en las recetas
	for recipe in crafting_recipes:
		if recipe.has("recipe") and recipe["recipe"] == recipe_key:
			print("Receta encontrada: ", recipe["name"])
			spawn_potion(recipe["name"])
			return
	print("Receta a buscar",str(recipe_key))
	print("No se encontró una receta con la combinación proporcionada.")

func spawn_potion(p_name):
	var potion_name = p_name
	for potion in craftable_items:
		if potion.has("name") and potion["name"] == potion_name:
			print("Pocion crafteada es: ",potion)
			add_potion(potion)
		else:
			print("Pocion no creada")
	print(p_name)

func add_potion(p_item):
	print(outbar_inventory)
	for i in range(outbar_size):
		if outbar_inventory[i] == null:
			p_item["quantity"] = 1
			p_item["scene_path"] = scene_path
			outbar_inventory[i] = p_item
			inventory_updated.emit()
			return true
	return false
