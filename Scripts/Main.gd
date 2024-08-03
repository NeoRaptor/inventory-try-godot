extends Node2D


# Scente tree node references used to spawn items
@onready var items = $Items
@onready var item_spawn_area = $ItemSpawnArea
@onready var collision_shape = $ItemSpawnArea/CollisionShape2D


func _ready():
	spawn_random_items(20)
	

# Get a random position to spawn the items
func get_random_position():
	var area_rect = collision_shape.shape.get_rect()
	var x = randf_range(0, area_rect.position.x)
	var y = randf_range(0, area_rect.position.y)
	return item_spawn_area.to_global(Vector2(x, y))
	
# Function to continually spawn items until the count or max attemps is reached
func spawn_random_items(count):
	print("attempting spawn items")
	var attempts = 0
	var spawned_count = 0
	while spawned_count < count and attempts < 100:
		var itm_position = get_random_position()
		#call the function to spawn items with a random number
		spawn_item(Global.spawnable_items[randi() % Global.spawnable_items.size()], itm_position)
		
		spawned_count += 1
		attempts += 1
		print("attempt succes at try "+ str(attempts))
		

# Create a physical instance of the item scene on the map underneath  /Items node, one at the time taking data from the 
# set item data funcion on inventory item?
func spawn_item(data, itm_position):
	var item_scene = preload("res://Scenes/Inventory_Item.tscn")
	var item_instance = item_scene.instantiate()
	item_instance.initiate_items(data["type"],data["name"],data["effect"],data["texture"])
	item_instance.global_position = itm_position
	items.add_child(item_instance)
	print(data["name"])
	print(str(position))

