extends Control


# Scene tree node references for manipulation

@onready var icon =  $InnerBorder/ItemIcon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var usage_panel = $UsagePanel

@onready var assign_button = $UsagePanel/AssignButton

@onready var outer_border = $OuterBorder

#Signas to notify drag status
signal drag_start(slot)
signal drag_end()

# Slot item variable and information
var item = null
var slot_index = -1
var is_assigned = false

#Set index to finally have a real slot available
func set_slot_index(new_index):
	slot_index = new_index

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_button_mouse_entered():
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true


func _on_item_button_mouse_exited():
	details_panel.visible = false

# Create defaul empty slots
func set_empty():
	icon.texture = null
	quantity_label.text = ""

func set_item(new_item):
	item = new_item
	icon.texture = new_item["texture"]
	quantity_label.text = str(new_item["quantity"])
	item_name.text = str(new_item["name"])
	item_type.text = str(new_item["type"])
	if item["effect"] != "":
		item_effect.text = str("+ ", item["effect"])
	else:
		item_effect.text = ""
	update_assigment_status()



func _on_drop_button_pressed():
	if item != null:
		var drop_position = Global.player_node.global_position
		var drop_offset = Vector2(0,20)
		drop_offset = drop_offset.rotated(Global.player_node.rotation)
		Global.drop_item(item, drop_position + drop_offset)
		Global.remove_item(item["type"],item["effect"])
		Global.remove_hotbar_item(item["type"],item["effect"])
		usage_panel.visible = false


func _on_use_button_pressed():
	usage_panel.visible = false
	if item != null and item["effect"] != "":
		if Global.player_node:
			Global.player_node.apply_item_effect(item)
			Global.remove_item(item["type"], item["effect"])
			Global.remove_hotbar_item(item["type"],item["effect"])
		else:
			print("404 player not foud o.O")


#Update the assign status text on the assign button
func update_assigment_status():
	is_assigned = Global.is_item_assigned_to_hotbar(item)
	if is_assigned:
		assign_button.text = "Unassing"
	else:
		assign_button.text = "Assign"


#assigs or unassigns the item to hotbar
func _on_assign_button_pressed():
	if item != null:
		if is_assigned:
			Global.unassign_hotbar_item(item["type"],item["effect"])
			is_assigned = false
		else:
			Global.add_item(item, true)
			is_assigned = true
		update_assigment_status()


func _on_item_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			if item != null:
				usage_panel.visible = !usage_panel.visible
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				outer_border.modulate = Color(1,1,0)
				drag_start.emit(self)
			else:
				outer_border.modulate = Color(1,1,1)
				drag_end.emit()
