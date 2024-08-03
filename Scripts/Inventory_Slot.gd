#Inventory_Slot.gd

extends Control


# Scene tree node references for manipulation

@onready var icon :=  $InnerBorder/ItemIcon
@onready var quantity_label := $InnerBorder/ItemQuantity
@onready var details_panel := $DetailsPanel
@onready var item_name := $DetailsPanel/ItemName
@onready var item_type := $DetailsPanel/ItemType
@onready var item_effect := $DetailsPanel/ItemEffect
@onready var usage_panel := $UsagePanel

@onready var assign_button := $UsagePanel/VBoxContainer/AssignButton
@onready var craft_button := $UsagePanel/VBoxContainer/CraftButton

@onready var outer_border := $OuterBorder

#Signas to notify drag status
signal drag_start(slot)
signal drag_end()

# Slot item variable and information
var item = null
var slot_index := -1
var is_assigned_hotbar := false
var is_assigned_craftbar := false

#Set index to finally have a real slot available
func set_slot_index(new_index : int):
	slot_index = new_index

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



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
	update_craft_status()



func _on_drop_button_pressed():
	if item != null:
		var drop_position : Vector2 = Global.player_node.global_position
		var drop_offset := Vector2(0,20)
		drop_offset = drop_offset.rotated(Global.player_node.rotation)
		Global.drop_item(item, drop_position + drop_offset)
		Global.remove_item(item["type"],item["effect"])
		Global.remove_hotbar_item(item["type"],item["effect"])
		Global.remove_outbar_item(item["type"],item["effect"])
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
	is_assigned_hotbar = Global.is_item_assigned_to_hotbar(item)
	if is_assigned_hotbar:
		assign_button.text = "Unassing"
	else:
		assign_button.text = "Assign"


#assigs or unassigns the item to hotbar
func _on_assign_button_pressed():
	if item != null:
		var inventory_full = false
		inventory_full = Global.is_hotbar_full()
		if is_assigned_hotbar:
			Global.unassign_hotbar_item(item["type"],item["effect"])
			is_assigned_hotbar = false
			print("restando? porque ", inventory_full)
			Global.hotbar_used -=1
		elif !is_assigned_hotbar and inventory_full:
			print("invetorio lleno")
		else:
			Global.add_item(item, true, false)
			is_assigned_hotbar = true
			print("sumando porque ", inventory_full)
		update_assigment_status()
		print(str(Global.hotbar_used))


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

#Update the assign status text on the assign button
func update_craft_status():
	is_assigned_craftbar = Global.is_item_assigned_to_craftbar(item)
	if is_assigned_craftbar:
		craft_button.text = "Remove"
	else:
		craft_button.text = "Use Ingredient"

func _on_craft_button_pressed():
	if item != null:
		var inventory_full = false
		inventory_full = Global.is_craftbar_full()
		if is_assigned_craftbar:
			Global.unassign_craftbar_item(item["type"],item["effect"])
			is_assigned_craftbar = false
			print("restando? porque ", inventory_full)
			Global.craftbar_used -=1
		elif !is_assigned_craftbar and inventory_full:
			print("invetorio lleno")
		else:
			Global.add_item(item, false, true)
			is_assigned_craftbar = true
			print("sumando porque ", inventory_full)
		update_assigment_status()
		print(str(Global.hotbar_used))

