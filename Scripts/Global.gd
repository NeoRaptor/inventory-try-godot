### Global.gd
extends Node

# Custom signals
signal inventory_updated

# Inventory items
var inventory = []

# Array of spawnable items > avoid special "quest" items, use commons for drops
var spawnable_items = [
	{"type": "Consumable","name": "Berry","effect": "Health","texture": preload("res://assets/Icons/icon31.png")},
	{"type": "Consumable","name": "Water","effect": "Stamina","texture": preload("res://assets/Icons/icon9.png")},
	{"type": "Consumable","name": "Mushroom","effect": "Armor","texture": preload("res://assets/Icons/icon32.png")},
	{"type": "Gift","name": "Gemstone","effect": "","texture": preload("res://assets/Icons/icon21.png")},
]

# Scene and node references
var player_node: Node = null

@onready var inventory_slot_scene = preload("res://Scenes/Inventory_Slot.tscn")

# Variables to hold the hotbar settings
var hotbar_size = 5
var hotbar_inventory = []

func _ready(): 
	# Initializes the inventory with 30 slots (spread over 9 blocks per row)
	inventory.resize(27)
	hotbar_inventory.resize(hotbar_size)
	
# Sets the player reference for inventory interactions
func set_player_reference(player):
	player_node = player
	
# Adds an item to the inventory, returns true if successful
func add_item(item, to_hotbar = false):
	
	var added_to_hotbar = false
	if to_hotbar:
		added_to_hotbar = add_hotbar_item(item)
		inventory_updated.emit()
		print("added to hot!")
	if not added_to_hotbar:
		for i in range(inventory.size()):
			# Check if the item exists in the inventory and matches both type and effect
			if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
				inventory[i]["quantity"] += item["quantity"]
				inventory_updated.emit()
				print("Item added", inventory)
				return true
			elif inventory[i] == null:
				inventory[i] = item
				inventory_updated.emit()
				print("Item added", inventory)
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
	var radius = 60
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_position.distance_to(position) < radius:
			var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position
	
# Function to drop the items after calculating a valid drop position

func drop_item(item_data, drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
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

#remove an item from the hotbar when its used or consumed to 0 so UPDATE not DELETE
func remove_hotbar_item(item_type, item_effect):
	for i in range(hotbar_inventory.size()):
		if hotbar_inventory[i] != null and hotbar_inventory[i]["type"] == item_type and hotbar_inventory[i]["effect"] == item_effect:
			if hotbar_inventory[i]["quantity"] <= 0:
				hotbar_inventory[i] = null
			inventory_updated.emit()
			return true
	return false

#unassign item from the hotbar without deleting it
func unassign_hotbar_item(item_type, item_effect):
	for i in range(hotbar_inventory.size()):
		if hotbar_inventory[i] != null and hotbar_inventory[i]["type"] == item_type and hotbar_inventory[i]["effect"] == item_effect:
			hotbar_inventory[i] = null
			inventory_updated.emit()
			return true
	return false

#Prevents duplicate item assigment
func is_item_assigned_to_hotbar(item_to_check):
	return item_to_check in hotbar_inventory

#Swaps inventory items based on their indices
func swap_inventory_items(index1, index2):
	if index1 < 0 or index1 > inventory.size() or index2 < 0 or index2 > inventory.size():
		return false
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
