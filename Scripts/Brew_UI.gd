extends Control


@onready var craftbar_container := $HBoxContainer/VBoxContainer/Potion_IN
@onready var craftbar_out := $HBoxContainer/VBoxContainer2/Potion_OUT


#Drag and drop variable?
var dragged_slot : Control = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.inventory_updated.connect(_update_craftbar_ui)
	Global.inventory_updated.connect(_update_craftbar_out)
	_update_craftbar_ui()
	_update_craftbar_out()

#create hotbar slots
func _update_craftbar_ui():
	clear_craftbar_container()
	for i in range(Global.craftbar_size):
		var slot : Control = Global.inventory_slot_scene.instantiate()
		slot.set_slot_index(i)
		
		slot.drag_start.connect(_on_drag_start)
		slot.drag_end.connect(_on_drag_end)
		
		craftbar_container.add_child(slot)
		if Global.craftbar_inventory[i] != null:
			slot.set_item(Global.craftbar_inventory[i])
		else:
			slot.set_empty()
		slot.update_craft_status()

func _update_craftbar_out():
	clear_craftbar_out()
	for i in range(Global.outbar_size):
		var slot : Control = Global.inventory_slot_scene.instantiate()
		slot.set_slot_index(i)
		
		slot.drag_start.connect(_on_drag_start)
		slot.drag_end.connect(_on_drag_end)
		
		craftbar_out.add_child(slot)
		if Global.outbar_inventory[i] != null:
			slot.set_item(Global.outbar_inventory[i])
		else:
			slot.set_empty()
		slot.update_craft_status()



#clear hotbar slots
func clear_craftbar_container():
	while craftbar_container.get_child_count() > 0:
		var child : Control = craftbar_container.get_child(0)
		craftbar_container.remove_child(child)
		child.queue_free()

func clear_craftbar_out():
	while craftbar_out.get_child_count() > 0:
		var child : Control = craftbar_out.get_child(0)
		craftbar_out.remove_child(child)
		child.queue_free()

#Store dragged slot reference
func _on_drag_start(slot_control : Control):
	dragged_slot = slot_control
	print("Dragging started from slot: ", dragged_slot)

func _on_drag_end():
	var target_slot : Control = get_slot_under_mouse()
	if target_slot and dragged_slot != target_slot:
		drop_slot(dragged_slot, target_slot)
	dragged_slot = null

#Get the current mouse position in the hotbar_container's coordinate system
func get_slot_under_mouse():
	var mouse_position : Vector2 = get_global_mouse_position()
	for slot : Control in craftbar_container.get_children():
		var slot_rect := Rect2(slot.global_position, slot.size)
		if slot_rect.has_point(mouse_position):
			return slot
	return null

func get_slot_index(slot : Control) -> int:
	for i in range(craftbar_container.get_child_count()):
		if craftbar_container.get_child(i) == slot:
			#Validate slot found
			return i
	#return invalid slot
	return -1

func drop_slot(slot1 : Control, slot2 : Control):
	var slot1_index : int = get_slot_index(slot1)
	var slot2_index : int = get_slot_index(slot2)
	if slot1_index == -1 or slot2_index == -1:
		print("Invalid slot found D:")
		return
	else:
		if Global.swap_craftbar_items(slot1_index, slot2_index):
			print("Dropping slot items: ", slot1, slot2)
			_update_craftbar_ui()


func _on_craft_button_pressed():
	Global.craft_potion(Global.craftbar_inventory)
